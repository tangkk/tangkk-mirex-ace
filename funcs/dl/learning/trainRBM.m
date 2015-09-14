function model = trainRBM(model_shape, gradient_function, training_data, learning_rate, mini_batch_size, n_iterations)
    model = (rand(model_shape) * 2 - 1) * 0.1;
    momentum_speed = zeros(model_shape);
    start_of_next_mini_batch = 1;
    for iteration_number = 1:n_iterations,
        if mod(iteration_number,1000) == 0
            disp(['iteration: ' num2str(iteration_number)]);
        end
        % stochastic mini-batch: randomly pick $mini_batch_size cases
        mini_batch = extract_ran_mini_batch(training_data, mini_batch_size);
        % mini_batch = extract_mini_batch(training_data, start_of_next_mini_batch, mini_batch_size);
        % start_of_next_mini_batch = mod(start_of_next_mini_batch + mini_batch_size, size(training_data, 2));
        gradient = gradient_function(model, mini_batch);
        % note that here in optimize.m we use "momentum_speed =
        % momentum_speed * momentum_multiplier + gradient", which is
        % different from optimize2.m (+ rather than -)
        momentum_speed = 0.9 * momentum_speed + gradient;
        model = model + momentum_speed * learning_rate;
    end
end
