% use RBM to do unsupervised pre-train
% 1 RBM

function model = rbm1_bias(n_hid, nclass, lr_rbm, mini_batch_size, n_iterations, name_dataset)
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
    rbm_w_1 = trainRBM([n_hid, size(data_sets.training.inputs,1)+1], ...
                     @(rbm_w_1, data) cd1_bias(rbm_w_1, data), ...  % discard labels
                     data_sets.training.inputs, ...
                     lr_rbm, mini_batch_size, ...
                     n_iterations);
    % rbm_w is now a weight matrix of <n_hid> by <number of visible units, i.e. 256>
    % show_rbm(rbm_w);
    input_to_hid = rbm_w_1;
    hidden_representation = logistic(input_to_hid * [ones(1,ncase);data_sets.training.inputs]);
    
    disp('restricted Boltzmann machine 2 training...');
    rbm_w_2 = trainRBM([nclass, size(hidden_representation,1)+1], ...
                     @(rbm_w_2, data) cd1_bias(rbm_w_2, data), ...  % discard labels
                     hidden_representation, ...
                     lr_rbm, mini_batch_size, ...
                     n_iterations);
    hid_to_class = rbm_w_2;
  
	model.input_to_hid = input_to_hid;
	model.hid_to_class = hid_to_class;
end
