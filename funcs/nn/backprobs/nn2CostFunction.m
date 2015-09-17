function [J, grad] = nn2CostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_1_size, ...
                                   hidden_layer_2_size, ...
                                   num_labels, ...
                                   X, y, lambda)

% Reshape nn_params back into the parameters Theta1, Theta2 and Theta3
Theta1 = reshape(nn_params(1:hidden_layer_1_size * (input_layer_size + 1)), ...
                 hidden_layer_1_size, (input_layer_size + 1));

Theta2 = reshape(nn_params(1+size(Theta1(:)):size(Theta1(:))+...
                  (hidden_layer_2_size * (hidden_layer_1_size + 1))), ...
                 hidden_layer_2_size, (hidden_layer_1_size + 1));
                 
Theta3 = reshape(nn_params(1+size(Theta1(:))+size(Theta2(:)):end), ...
                 num_labels, (hidden_layer_2_size + 1));
                 

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
Theta3_grad = zeros(size(Theta3));

sizeTheta1 = size(Theta1);
sizeTheta2 = size(Theta2);
sizeTheta3 = size(Theta3);
Theta1_grad = zeros(sizeTheta1(1), sizeTheta1(2));
Theta2_grad = zeros(sizeTheta2(1), sizeTheta2(2));
Theta3_grad = zeros(sizeTheta3(1), sizeTheta3(2));

% vectorized version of backprob (gradient):
% for understanding, for example:
% X is of size 5000*400
% y is of size 5000*1
% Theta1 is of size 25*401 (layer(i)*(layer(i-1)+1))
% Theta2 is of size 20*26
% Theta3 is of size 10*21

a1 = [ones(1,m);X']; % a1 will be of size 401*5000
z2 = Theta1*a1; % z2 will be of size 25*5000
a2 = [ones(1,m);sigmoid(z2)]; % a2 will be of size 26*5000
z3 = Theta2*a2; % z3 will be of size 20*5000
a3 = [ones(1,m);sigmoid(z3)]; % a3 will be of size 21*5000
z4 = Theta3*a3; % z4 will be of size 10*5000
a4 = sigmoid(z4); % a4 will be of size 10*5000
% ****** pre-processing output labels ******
% convert to one-hot labels if needed
if size(y,2) == 1
    yi = zeros(num_labels, m);
    ass = 0:num_labels:num_labels*(m-1); % indexing different cols
    yi(y'+ass) = 1; % yi will be of size 10*5000
else
    yi = y';
end

% ****** compute cost ******
sumJ = sum(sum(-yi.*log(a4) - (1 - yi).*log(1-a4))); % sumJ is a scalar
J = sumJ / m;
J = J + (lambda / (2*m)) * (sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)) + sum(sum(Theta3(:,2:end).^2)));
% **************************
delta4 = a4 - yi; % delta4 will be of size 10*5000
delta3 = (Theta3'*delta4).*[ones(1,m);sigmoidGradient(z3)];
delta3 = delta3(2:end,:); % delta3 will be of size 20*5000
delta2 = (Theta2'*delta3).*[ones(1,m);sigmoidGradient(z2)];
delta2 = delta2(2:end,:); % delta2 will be of size 25*5000
% ****** compute gradient ******
Theta1_grad = Theta1_grad + delta2*a1'; % same size as Theta1
Theta2_grad = Theta2_grad + delta3*a2'; % same size as Theta2
Theta3_grad = Theta3_grad + delta4*a3'; % same size as Theta3

Theta1_grad = Theta1_grad ./ m + (lambda / m) .* [zeros(sizeTheta1(1),1) Theta1(:,2:end)];
Theta2_grad = Theta2_grad ./ m + (lambda / m) .* [zeros(sizeTheta2(1),1) Theta2(:,2:end)];
Theta3_grad = Theta3_grad ./ m + (lambda / m) .* [zeros(sizeTheta3(1),1) Theta3(:,2:end)];

grad = [Theta1_grad(:) ; Theta2_grad(:) ; Theta3_grad(:)];

end
