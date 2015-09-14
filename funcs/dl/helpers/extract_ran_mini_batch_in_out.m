function mini_batch = extract_ran_mini_batch_in_out(data_set, n_cases)
    m = size(data_set.targets,2);
    ranp = randperm(m);
    mini_batch.inputs = data_set.inputs(:, ranp(1:n_cases));
    mini_batch.targets = data_set.targets(:, ranp(1:n_cases));
end

