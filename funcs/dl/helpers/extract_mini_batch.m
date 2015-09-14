function mini_batch = extract_mini_batch(data_set, start_i, n_cases)
    mini_batch = data_set(:, start_i : start_i + n_cases - 1);
end

