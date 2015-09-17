% Deep Belief Network:
% DNN + RBM architecture
% use RBM to do unsupervised pre-train, then use NN to do supervised back-prob train
% 1 RBM

% the format of the data_set should conform with:
% it contains a struct, with a field called "data".
% the "data" field is also a struct, containing structs "training", "validation"
% and "test", where each of which contains "inputs" and "targets" matrix
function model = dbn1(n_hid, nclass, lr_rbm, lr_classification, wd, mini_batch_size, n_iterations, name_dataset)
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
    rbm_w_1 = trainRBM([n_hid, size(data_sets.training.inputs,1)], ...
                     @(rbm_w_1, data) cd1(rbm_w_1, data), ...  % discard labels
                     data_sets.training.inputs, ...
                     lr_rbm, mini_batch_size, ...
                     n_iterations);
    % rbm_w is now a weight matrix of <n_hid> by <number of visible units, i.e. 256>
    % show_rbm(rbm_w);
    input_to_hid = rbm_w_1;
    hidden_representation = logistic(input_to_hid * data_sets.training.inputs);
    
%     disp('restricted Boltzmann machine 2 training...');
%     rbm_w_2 = trainRBM([nclass, size(hidden_representation,1)], ...
%                      @(rbm_w_2, data) cd1(rbm_w_2, data), ...  % discard labels
%                      hidden_representation, ...
%                      lr_rbm, mini_batch_size, ...
%                      n_iterations);
    hid_to_class = 0;
    
    % train DNN
    data_t.inputs = data_sets.training.inputs;
    data_t.targets = data_sets.training.targets;
    data_v.inputs = data_sets.validation.inputs;
    data_v.targets = data_sets.validation.targets;
    disp('discrimination fine-tuning...');
    model = trainDNN1([size(data_sets.training.targets,1), n_hid], @(model_, data) d_loss_by_d_model(model_, data, wd),...
        data_t, data_v, input_to_hid, hid_to_class, lr_classification, wd, mini_batch_size, n_iterations);
    input_to_hid = model.input_to_hid;
    hid_to_class = model.hid_to_class;
    
    for data_details = reshape({'training', data_sets.training, 'validation', data_sets.validation, 'test', data_sets.test}, [2, 3]),
        data_name = data_details{1};
        data = data_details{2};
        hid_input = input_to_hid * data.inputs; % size: <number of hidden units> by <number of data cases>
        hid_output = logistic(hid_input); % size: <number of hidden units> by <number of data cases>
        class_input = hid_to_class * hid_output; % size: <number of classes> by <number of data cases>
        class_normalizer = log_sum_exp_over_rows(class_input); % log(sum(exp of class_input)) is what we subtract to get properly normalized log class probabilities. size: <1> by <number of data cases>
        log_class_prob = class_input - repmat(class_normalizer, [size(class_input, 1), 1]); % log of probability of each class. size: <number of classes, i.e. 10> by <number of data cases>
        error_rate = mean(double(argmax_over_rows(class_input) ~= argmax_over_rows(data.targets))); % scalar
        loss = -mean(sum(log_class_prob .* data.targets, 1)); % scalar. select the right log class probability using that sum; then take the mean over all data cases.
        fprintf('For the %s data, the classification cross-entropy loss is %f, and the classification error rate (i.e. the misclassification rate) is %f\n', data_name, loss, error_rate);
    end
end
