% a 1-hidden-layer neural network
% call convention example:
% nn1('data-B-12-key.mat',544,1000,1)
function nn1(datapath, hs1, maxiter, lambda)

load(datapath); % data must conform with X, y format

input_layer_size  = size(X,2);
hidden_layer_size = hs1;
num_labels = max(y);  

m = size(X, 1);

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

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
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

pred = predictNN1(Theta1, Theta2, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

save('nn1param.mat', 'Theta1', 'Theta2');
