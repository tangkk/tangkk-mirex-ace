function report_nn1(data_sets, model)

input_to_hid = model.input_to_hid;
hid_to_class = model.hid_to_class;

for data_details = reshape({'training', data_sets.training, 'validation', data_sets.validation, 'test', data_sets.test}, [2, 3]),
    data_name = data_details{1};
    data = data_details{2};
    hid_input = input_to_hid * data.inputs; % size: <number of hidden units> by <number of data cases>
    hid_output = logistic(hid_input); % size: <number of hidden units> by <number of data cases>
    class_input = hid_to_class * hid_output; % size: <number of classes> by <number of data cases>
    class_normalizer = log_sum_exp_over_rows(class_input); % log(sum(exp of class_input)) is what we subtract to get properly normalized log class probabilities. size: <1> by <number of data cases>
    log_class_prob = class_input - repmat(class_normalizer, [size(class_input, 1), 1]); % log of probability of each class. size: <number of classes, i.e. 10> by <number of data cases>
    error_rate = mean(double(argmax_over_rows(class_input) ~= argmax_over_rows(data.targets))); % scalar
    loss = -mean(sum(log_class_prob .* data.targets, 1)); % scalar. select the right log class probability using that sum; then take the mean over all data cases.
    fprintf('For the %s data, the classification cross-entropy loss is %f, and the classification error rate (i.e. the misclassification rate) is %f\n', data_name, loss, error_rate);
end