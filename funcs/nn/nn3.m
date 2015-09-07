% a 3-hidden-layer neural network
function nn3(datapath, hs1, hs2, hs3)

load(datapath);

input_layer_size  = size(X,2);
hidden_layer_1_size = str2double(hs1);
hidden_layer_2_size = str2double(hs2);
hidden_layer_3_size = str2double(hs3);
num_labels = max(y);

m = size(X, 1);

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_1_size);
initial_Theta2 = randInitializeWeights(hidden_layer_1_size, hidden_layer_2_size);
initial_Theta3 = randInitializeWeights(hidden_layer_2_size, hidden_layer_3_size);
initial_Theta4 = randInitializeWeights(hidden_layer_3_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:) ; initial_Theta4(:)];

% checkNN3Gradients;

%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 50);

%  You should also try different values of lambda
lambda = 1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nn3CostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_1_size, ...
                                   hidden_layer_2_size, ...
                                   hidden_layer_3_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_1_size * (input_layer_size + 1)), ...
                 hidden_layer_1_size, (input_layer_size + 1));

Theta2 = reshape(nn_params(1+size(Theta1(:)):...
                  size(Theta1(:))+...
                  (hidden_layer_2_size * (hidden_layer_1_size + 1))), ...
                 hidden_layer_2_size, (hidden_layer_1_size + 1));
                 
Theta3 = reshape(nn_params(1+size(Theta1(:))+size(Theta2(:)):...
                  size(Theta1(:))+size(Theta2(:))+...
                  (hidden_layer_3_size * (hidden_layer_2_size + 1))), ...
                 hidden_layer_3_size, (hidden_layer_2_size + 1));
                 
Theta4 = reshape(nn_params(1+size(Theta1(:))+size(Theta2(:))+size(Theta3(:)):...
                  end),...
                 num_labels, (hidden_layer_3_size + 1));

pred = predictNN3(Theta1, Theta2, Theta3, Theta4, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

save('nn3param.mat', 'Theta1', 'Theta2', 'Theta3', 'Theta4');
