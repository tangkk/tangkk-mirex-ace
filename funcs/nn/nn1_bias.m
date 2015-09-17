% a 1-hidden-layer neural network
% call convention example:
% nn1('data-B-12-key.mat',544,1000,1)
% init_model can be specified if there's one pre-trained by RBM, else, give a "[]"
function model = nn1_bias(n_hid, nclass, maxiter, lambda, init_model, name_dataset)

temp = load(name_dataset); % data must conform with X, y format
data_sets = temp.data;

% if not one-hot target, convert it to one-hot first
yp = data_sets.training.targets;
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

X = data_sets.training.inputs';
y = data_sets.training.targets';

input_layer_size  = size(X,2);
hidden_layer_size = n_hid;
num_labels = nclass;

ncase = size(X, 1);

if isempty(init_model)
	initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
	initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
else
	initial_Theta1 = init_model.input_to_hid;
    % whether the last layer is also pre-trained
    if isempty(init_model.hid_to_class)
        initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
    else
        initial_Theta2 = init_model.hid_to_class;
    end
end

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

% checkNN1Gradients;

%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', maxiter);

% %  You should also try different values of lambda
% lambda = 1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nn1CostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, ~] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

pred = predictNN1(Theta1, Theta2, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == yp')));

model.input_to_hid = Theta1;
model.hid_to_class = Theta2;

report_nn1_bias(data_sets, model);
