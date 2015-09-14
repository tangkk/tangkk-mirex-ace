function ret = loss(model, data, wd_coefficient)
  % model.input_to_hid is a matrix of size <number of hidden units> by <number of inputs i.e. 256>. It contains the weights from the input units to the hidden units.
  % model.hid_to_class is a matrix of size <number of classes i.e. 10> by <number of hidden units>. It contains the weights from the hidden units to the softmax units.
  % data.inputs is a matrix of size <number of inputs i.e. 256> by <number of data cases>. Each column describes a different data case. 
  % data.targets is a matrix of size <number of classes i.e. 10> by <number of data cases>. Each column describes a different data case. It contains a one-of-N encoding of the class, i.e. one element in every column is 1 and the others are 0.
	 
  % Before we can calculate the loss, we need to calculate a variety of intermediate values, like the state of the hidden units. This is the
  % forward pass, and you'll likely want to copy it into d_loss_by_d_model, because these values are also very useful for that function.
  hid_input = model.input_to_hid * data.inputs; % input to the hidden units, i.e. before the logistic. size: <number of hidden units> by <number of data cases>
  hid_output = logistic(hid_input); % output of the hidden units, i.e. after the logistic. size: <number of hidden units> by <number of data cases>
  class_input = model.hid_to_class * hid_output; % input to the components of the softmax. size: <number of classes, i.e. 10> by <number of data cases>
  
  % The following three lines of code implement the softmax.
  % However, it's written differently from what the lectures say.
  % In the lectures, a softmax is described using an exponential divided by a sum of exponentials.
  % What we do here is exactly equivalent (you can check the math or just check it in practice), but this is more numerically stable. 
  % "Numerically stable" means that this way, there will never be really big numbers involved.
  % The exponential in the lectures can lead to really big numbers, which are fine in mathematical equations, but can lead to all sorts of problems in Octave.
  % Octave isn't well prepared to deal with really large numbers, like the number 10 to the power 1000. Computations with such numbers get unstable, so we avoid them.
  class_normalizer = log_sum_exp_over_rows(class_input); % log(sum(exp of class_input)) is what we subtract to get properly normalized log class probabilities. size: <1> by <number of data cases>
  log_class_prob = class_input - repmat(class_normalizer, [size(class_input, 1), 1]); % log of probability of each class. size: <number of classes, i.e. 10> by <number of data cases>
  class_prob = exp(log_class_prob); % probability of each class. Each column (i.e. each case) sums to 1. size: <number of classes, i.e. 10> by <number of data cases>
  
  classification_loss = -mean(sum(log_class_prob .* data.targets, 1)); % select the right log class probability using that sum; then take the mean over all data cases.
  wd_loss = sum(model_to_theta(model).^2)/2*wd_coefficient; % weight decay loss. very straightforward: E = 1/2 * wd_coeffecient * theta^2
  ret = classification_loss + wd_loss;
end