function loss_2_bias(model, data)
input_to_hid_1 = model.input_to_hid_1;
hid_1_to_hid_2 = model.hid_1_to_hid_2;
hid_2_to_class = model.hid_2_to_class;
m = size(data.targets,2);
hid_1_input = input_to_hid_1 * [ones(1,m);data.inputs]; % size: <number of hidden units> by <number of data cases>
hid_1_output = logistic(hid_1_input); % size: <number of hidden units> by <number of data cases>
hid_2_input = hid_1_to_hid_2 * [ones(1,m);hid_1_output];
hid_2_output = logistic(hid_2_input);
class_input = hid_2_to_class * [ones(1,m);hid_2_output]; % size: <number of classes> by <number of data cases>
class_normalizer = log_sum_exp_over_rows(class_input); % log(sum(exp of class_input)) is what we subtract to get properly normalized log class probabilities. size: <1> by <number of data cases>
log_class_prob = class_input - repmat(class_normalizer, [size(class_input, 1), 1]); % log of probability of each class. size: <number of classes, i.e. 10> by <number of data cases>
error_rate = mean(double(argmax_over_rows(class_input) ~= argmax_over_rows(data.targets))); % scalar
loss = -mean(sum(log_class_prob .* data.targets, 1)); % scalar. select the right log class probability using that sum; then take the mean over all data cases.
fprintf('classification cross-entropy loss is %f, classification error rate is %f\n', loss, error_rate);
end