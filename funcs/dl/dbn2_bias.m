% Deep Belief Network:
% DNN + RBM architecture
% use RBM to do unsupervised pre-train, then use NN to do supervised back-prob train
% 2 RBMs

% the format of the data_set should conform with:
% it contains a struct, with a field called "data".
% the "data" field is also a struct, containing structs "training", "validation"
% and "test", where each of which contains "inputs" and "targets" matrix
function dbn2_bias(n_hid_1, n_hid_2, nclass, lr_rbm, lr_classification, wd, mini_batch_size, n_iterations, name_dataset)
    % load data
    temp = load(name_dataset);
    data_sets = temp.data;
    
    % if not one-hot target, convert it to one-hot first
    if size(data_sets.training.targets,1) == 1
        y = data_sets.training.targets;
        ncases = size(y,2);
        yi = zeros(nclass, ncases);
        ass = 0:nclass:nclass*(ncases-1);
        yi(y+ass) = 1;
        data_sets.training.targets = yi;
        
        y = data_sets.validation.targets;
        ncases = size(y,2);
        yi = zeros(nclass, ncases);
        ass = 0:nclass:nclass*(ncases-1);
        yi(y+ass) = 1;
        data_sets.validation.targets = yi;
        
        y = data_sets.test.targets;
        ncases = size(y,2);
        yi = zeros(nclass, ncases);
        ass = 0:nclass:nclass*(ncases-1);
        yi(y+ass) = 1;
        data_sets.test.targets = yi;
    end
    
    % train RBM
    disp('restricted Boltzmann machine 1 training...');
    rbm_w_1 = trainRBM([n_hid_1, size(data_sets.training.inputs,1)+1], ...
                     @(rbm_w_1, data) cd1_bias(rbm_w_1, data), ...  % discard labels
                     data_sets.training.inputs, ...
                     lr_rbm, mini_batch_size, ...
                     n_iterations);
    input_to_hid_1 = rbm_w_1;
    m = size(data_sets.training.inputs,2);
    hidden_1_representation = logistic(input_to_hid_1 * [ones(1,m);data_sets.training.inputs]);
    
    disp('restricted Boltzmann machine 2 training...');
    rbm_w_2 = trainRBM([n_hid_2, size(hidden_1_representation,1)+1], ...
                     @(rbm_w_2, data) cd1_bias(rbm_w_2, data), ...  % discard labels
                     hidden_1_representation, ...
                     lr_rbm, mini_batch_size,...
                     n_iterations);
    hid_1_to_hid_2 = rbm_w_2;
    m = size(hidden_1_representation,2);
    hidden_2_representation = logistic(hid_1_to_hid_2 * [ones(1,m);hidden_1_representation]);
    
%     disp('restricted Boltzmann machine 3 training...');
%     rbm_w_3 = trainRBM([nclass, size(hidden_2_representation,1)], ...
%                      @(rbm_w_3, data) cd1(rbm_w_3, data), ...  % discard labels
%                      hidden_2_representation, ...
%                      lr_rbm, mini_batch_size,...
%                      n_iterations);
    hid_2_to_class = 0;
    
    % train DNN
    data_t.inputs = data_sets.training.inputs;
    data_t.targets = data_sets.training.targets;
    data_v.inputs = data_sets.validation.inputs;
    data_v.targets = data_sets.validation.targets;
    disp('discrimination fine-tuning...');
    model = trainDNN2([size(data_sets.training.targets,1), n_hid_2+1], @(model_, data) d_loss_by_d_model_2_bias(model_, data, wd),...
        data_t, data_v, input_to_hid_1, hid_1_to_hid_2, hid_2_to_class, lr_classification, wd, mini_batch_size, n_iterations);
    input_to_hid_1 = model.input_to_hid_1;
    hid_1_to_hid_2 = model.hid_1_to_hid_2;
    hid_2_to_class = model.hid_2_to_class;
    
    % report results
%     fid = fopen('log.txt','a');
%     fprintf(fid,'dbn2(%d,%d,%d)\n',n_hid_1,n_hid_2,nclass);
    for data_details = reshape({'training', data_sets.training, 'validation', data_sets.validation, 'test', data_sets.test}, [2, 3]),
        data_name = data_details{1};
        data = data_details{2};
        m = size(data.targets,2);
        hid_1_input = input_to_hid_1 * [ones(1,m);data.inputs]; % size: <number of hidden units> by <number of data cases>
        hid_1_output = logistic(hid_1_input); % size: <number of hidden units> by <number of data cases>
        hid_2_input = hid_1_to_hid_2 * [ones(1,m);hid_1_output];
        hid_2_output = logistic(hid_2_input);
        class_input = hid_2_to_class * [ones(1,m);hid_2_output]; % size: <number of classes> by <number of data cases>
        class_normalizer = log_sum_exp_over_rows(class_input); % log(sum(exp of class_input)) is what we subtract to get properly normalized log class probabilities. size: <1> by <number of data cases>
        log_class_prob = class_input - repmat(class_normalizer, [size(class_input, 1), 1]); % log of probability of each class. size: <number of classes, i.e. 10> by <number of data cases>
        error_rate = mean(double(argmax_over_rows(class_input) ~= argmax_over_rows(data.targets))); % scalar
        loss = -mean(sum(log_class_prob .* data.targets, 1)); % scalar. select the right log class probability using that sum; then take the mean over all data cases.
        fprintf('For the %s data, the classification cross-entropy loss is %f, and the classification error rate (i.e. the misclassification rate) is %f\n', data_name, loss, error_rate);
    end
%     fclose(fid);
    save('dbn2model.mat','model');
end
