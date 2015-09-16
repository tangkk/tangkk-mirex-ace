function loss_2(model, data, wd_coefficient)
input_to_hid_1 = model.input_to_hid_1;
hid_1_to_hid_2 = model.hid_1_to_hid_2;
hid_2_to_class = model.hid_2_to_class;
hid_1_input = input_to_hid_1 * data.inputs; % size: <number of hidden units> by <number of data cases>
hid_1_output = logistic(hid_1_input); % size: <number of hidden units> by <number of data cases>
hid_2_input = hid_1_to_hid_2 * hid_1_output;
hid_2_output = logistic(hid_2_input);
class_input = hid_2_to_class * hid_2_output; % size: <number of classes> by <number of data cases>
class_normalizer = log_sum_exp_over_rows(class_input); % log(sum(exp of class_input)) is what we subtract to get properly normalized log class probabilities. size: <1> by <number of data cases>
log_class_prob = class_input - repmat(class_normalizer, [size(class_input, 1), 1]); % log of probability of each class. size: <number of classes, i.e. 10> by <number of data cases>
error_rate = mean(double(argmax_over_rows(class_input) ~= argmax_over_rows(data.targets))); % scalar
classification_loss = -mean(sum(log_class_prob .* data.targets, 1)); % scalar. select the right log class probability using that sum; then take the mean over all data cases.
m = size(data.targets,2);
wd_loss = wd_coefficient*sum(model_to_theta_2(model).^2)/(2*m);
loss = classification_loss + wd_loss;
fprintf('loss is %f, classification error rate is %f\n', loss, error_rate);
end