% use RBM to do unsupervised pre-train
% 2 RBMs

function model = rbm2_bias(n_hid_1, n_hid_2, nclass, lr_rbm, mini_batch_size, n_iterations, name_dataset, lastlayer)
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
    
    ncase = size(data_sets.training.inputs,2);
    
    % train RBM
    disp('restricted Boltzmann machine 1 training...');
    rbm_w_1 = trainRBM([n_hid_1, size(data_sets.training.inputs,1)+1], ...
                     @(rbm_w_1, data) cd1_bias(rbm_w_1, data), ...  % discard labels
                     data_sets.training.inputs, ...
                     lr_rbm, mini_batch_size, ...
                     n_iterations);
    input_to_hid_1 = rbm_w_1;
    hidden_1_representation = logistic(input_to_hid_1 * [ones(1,ncase);data_sets.training.inputs]);
    
    disp('restricted Boltzmann machine 2 training...');
    rbm_w_2 = trainRBM([n_hid_2, size(hidden_1_representation,1)+1], ...
                     @(rbm_w_2, data) cd1_bias(rbm_w_2, data), ...  % discard labels
                     hidden_1_representation, ...
                     lr_rbm, mini_batch_size,...
                     n_iterations);
    hid_1_to_hid_2 = rbm_w_2;
    hidden_2_representation = logistic(hid_1_to_hid_2 * [ones(1,ncase);hidden_1_representation]);
    
    if lastlayer == 1
        disp('restricted Boltzmann machine 3 training...');
        rbm_w_3 = trainRBM([nclass, size(hidden_2_representation,1)+1], ...
                         @(rbm_w_3, data) cd1_bias(rbm_w_3, data), ...  % discard labels
                         hidden_2_representation, ...
                         lr_rbm, mini_batch_size,...
                         n_iterations);
        hid_2_to_class = rbm_w_3;
    else
        % don't pre-train the last layer
        hid_2_to_class = [];
    end
	
	model.input_to_hid_1 = input_to_hid_1;
	model.hid_1_to_hid_2 = hid_1_to_hid_2;
	model.hid_2_to_class = hid_2_to_class;
    
end
