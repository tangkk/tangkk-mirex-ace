function ret = log_sum_exp_over_rows(matrix)
  % This computes log(sum(exp(a), 1)) in a numerically stable way
  maxs_small = max(matrix, [], 1);
  maxs_big = repmat(maxs_small, [size(matrix, 1), 1]);
  ret = log(sum(exp(matrix - maxs_big), 1)) + maxs_small;
end