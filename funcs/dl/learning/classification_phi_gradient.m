function d_phi_by_d_input_to_class = classification_phi_gradient(input_to_class, data)
% This is about a very simple model: there's an input layer, and a softmax output layer. There are no hidden layers, and no biases.
% This returns the gradient of phi (a.k.a. negative the loss) for the <input_to_class> matrix.
% <input_to_class> is a matrix of size <number of classes> by <number of input units>.
% <data> has fields .inputs (matrix of size <number of input units> by <number of data cases>) and .targets (matrix of size <number of classes> by <number of data cases>).
% first: forward pass
    class_input = input_to_class * data.inputs; % input to the components of the softmax. size: <number of classes> by <number of data cases>
    class_normalizer = log_sum_exp_over_rows(class_input); % log(sum(exp)) is what we subtract to get normalized log class probabilities. size: <1> by <number of data cases>
    log_class_prob = class_input - repmat(class_normalizer, [size(class_input, 1), 1]); % log of probability of each class. size: <number of classes> by <number of data cases>
    class_prob = exp(log_class_prob); % probability of each class. Each column (i.e. each case) sums to 1. size: <number of classes> by <number of data cases>
    % now: gradient computation
    d_loss_by_d_class_input = -(data.targets - class_prob) ./ size(data.inputs, 2); % size: <number of classes> by <number of data cases>
    d_loss_by_d_input_to_class = d_loss_by_d_class_input * data.inputs.'; % size: <number of classes> by <number of input units>
    d_phi_by_d_input_to_class = -d_loss_by_d_input_to_class;
end