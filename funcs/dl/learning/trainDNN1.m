function model = trainDNN1(model_shape, gradient_function, training_data, validation_data, input_to_hid, hid_to_class, learning_rate, wd, mini_batch_size, n_iterations)
    model.input_to_hid = input_to_hid;
    model.hid_to_class = randInitializeWeights_nb(model_shape(2),model_shape(1));
%     model.hid_to_class = (rand(model_shape) * 2 - 1) * 0.1;
%     model.hid_to_class = hid_to_class;
    momentum_speed_input_to_hid = zeros(size(model.input_to_hid));
    momentum_speed_hid_to_class = zeros(size(model.hid_to_class));
    start_of_next_mini_batch = 1;
    for iteration_number = 1:n_iterations,
        if mod(iteration_number,100) == 0
            disp(['iteration: ' num2str(iteration_number)]);
            if size(input_to_hid,1) ~= model_shape(2)
                fprintf('for training data:');
                loss_bias(model,training_data, wd);
                fprintf('for validation data:');
                loss_bias(model,validation_data, wd);
            else
                fprintf('for training data:');
                loss(model,training_data, wd);
                fprintf('for validation data:');
                loss(model,validation_data, wd);
            end
        end
        % mini_batch = extract_mini_batch_in_out(training_data, start_of_next_mini_batch, mini_batch_size);
        % start_of_next_mini_batch = mod(start_of_next_mini_batch + mini_batch_size, size(training_data.inputs, 2));
        mini_batch = extract_ran_mini_batch_in_out(training_data, mini_batch_size);
        gradient = gradient_function(model, mini_batch);
        % note that here in optimize2.m we use "momentum_speed =
        % momentum_speed * momentum_multiplier - gradient", which is
        % different from optimize.m (- rather than +)
        % because of the sign of the gradient is computed differently
        momentum_speed_input_to_hid = 0.9 * momentum_speed_input_to_hid - gradient.input_to_hid;
        momentum_speed_hid_to_class = 0.9 * momentum_speed_hid_to_class - gradient.hid_to_class;
        model.input_to_hid = model.input_to_hid + momentum_speed_input_to_hid * learning_rate;
        model.hid_to_class = model.hid_to_class + momentum_speed_hid_to_class * learning_rate;
    end
end
