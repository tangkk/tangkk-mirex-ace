function [J, grad] = nn1CostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


sizeTheta1 = size(Theta1);
sizeTheta2 = size(Theta2);
Theta1_grad = zeros(sizeTheta1(1), sizeTheta1(2));
Theta2_grad = zeros(sizeTheta2(1), sizeTheta2(2));

% vectorized version of backprob (gradient):
% for understanding, for example:
% X is of size 5000*400
% y is of size 5000*1
% Theta1 is of size 25*401 (layer(i)*(layer(i-1)+1))
% Theta2 is of size 10*26
a1 = [ones(1,m);X']; % a1 will be of size 401*5000
z2 = Theta1*a1; % z2 will be of size 25*5000
a2 = [ones(1,m);sigmoid(z2)]; % a2 will be of size 26*5000
z3 = Theta2*a2; % z3 will be of size 10*5000
a3 = sigmoid(z3); % a3 will be of size 10*5000
yi = zeros(num_labels, m);
ass = 0:num_labels:num_labels*(m-1); % indexing different cols
yi(y'+ass) = 1; % yi will be of size 10*5000
% ****** compute cost ******
sumJ = sum(sum(-yi.*log(a3) - (1 - yi).*log(1-a3))); % sumJ is a scalar
J = sumJ / m;
J = J + (lambda / (2*m)) * (sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));
% **************************
delta3 = a3 - yi; % delta3 will be of size 10*5000
delta2 = (Theta2'*delta3).*[ones(1,m);sigmoidGradient(z2)]; % delta2 will be of size 26*5000
delta2 = delta2(2:end,:); % delta2 will be of size 25*5000
% ****** compute gradient ******
Theta1_grad = Theta1_grad + delta2*a1'; % same size as Theta1
Theta2_grad = Theta2_grad + delta3*a2'; % same size as Theta2
Theta1_grad = Theta1_grad ./ m + (lambda / m) .* [zeros(sizeTheta1(1),1) Theta1(:,2:end)];
Theta2_grad = Theta2_grad ./ m + (lambda / m) .* [zeros(sizeTheta2(1),1) Theta2(:,2:end)];

grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
