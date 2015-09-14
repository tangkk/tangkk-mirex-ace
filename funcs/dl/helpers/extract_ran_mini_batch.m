function mini_batch = extract_ran_mini_batch(data_set, n_cases)
    m = size(data_set,2);
    ranp = randperm(m);
    mini_batch = data_set(:, ranp(1:n_cases));
end

