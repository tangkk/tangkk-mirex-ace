function test_gradient(model, data, wd_coefficient)
  base_theta = model_to_theta(model);
  h = 1e-2;
  correctness_threshold = 1e-5;
  analytic_gradient_struct = d_loss_by_d_model(model, data, wd_coefficient);
  if size(fieldnames(analytic_gradient_struct), 1) ~= 2,
     error('The object returned by function d_loss_by_d_model should have exactly two field names: .input_to_hid and .hid_to_class');
  end
  if any(size(analytic_gradient_struct.input_to_hid) ~= size(model.input_to_hid)),
     error(sprintf(['The size of .input_to_hid of the return value of d_loss_by_d_model (currently [%d, %d]) should be same as the size of model.input_to_hid (currently [%d, %d])'], size(analytic_gradient_struct.input_to_hid), size(model.input_to_hid)));
  end
  if any(size(analytic_gradient_struct.hid_to_class) ~= size(model.hid_to_class)),
     error(sprintf(['The size of .hid_to_class of the return value of d_loss_by_d_model (currently [%d, %d]) should be same as the size of model.hid_to_class (currently [%d, %d])'], size(analytic_gradient_struct.hid_to_class), size(model.hid_to_class)));
  end
  analytic_gradient = model_to_theta(analytic_gradient_struct);
  if any(isnan(analytic_gradient)) || any(isinf(analytic_gradient)),
     error('Your gradient computation produced a NaN or infinity. That is an error.')
  end
  % We want to test the gradient not for every element of theta, because that's a lot of work. Instead, we test for only a few elements. If there's an error, this is probably enough to find that error.
  % We want to first test the hid_to_class gradient, because that's most likely to be correct (it's the easier one).
  % Let's build a list of theta indices to check. We'll check 20 elements of hid_to_class, and 80 elements of input_to_hid (it's bigger than hid_to_class).
  input_to_hid_theta_size = prod(size(model.input_to_hid));
  hid_to_class_theta_size = prod(size(model.hid_to_class));
  big_prime = 1299721; % 1299721 is prime and thus ensures a somewhat random-like selection of indices.
  hid_to_class_indices_to_check = mod(big_prime * (1:20), hid_to_class_theta_size) + 1 + input_to_hid_theta_size;
  input_to_hid_indices_to_check = mod(big_prime * (1:80), input_to_hid_theta_size) + 1;
  indices_to_check = [hid_to_class_indices_to_check, input_to_hid_indices_to_check];
  for i = 1:100,
    test_index = indices_to_check(i);
    analytic_here = analytic_gradient(test_index);
    theta_step = base_theta * 0;
    theta_step(test_index) = h;
    contribution_distances = [-4:-1, 1:4];
    contribution_weights = [1/280, -4/105, 1/5, -4/5, 4/5, -1/5, 4/105, -1/280];
    temp = 0;
    for contribution_index = 1:8,
      temp = temp + loss(theta_to_model(base_theta + theta_step * contribution_distances(contribution_index)), data, wd_coefficient) * contribution_weights(contribution_index);
    end
    fd_here = temp / h;
    diff = abs(analytic_here - fd_here);
    % fprintf('%d %e %e %e %e\n', test_index, base_theta(test_index), diff, fd_here, analytic_here);
    if (diff > correctness_threshold) && (diff / (abs(analytic_here) + abs(fd_here)) > correctness_threshold),
      part_names = {'input_to_hid', 'hid_to_class'};
      error(sprintf('Theta element #%d (part of %s), with value %e, has finite difference gradient %e but analytic gradient %e. That looks like an error.\n', test_index, part_names{(i<=20)+1}, base_theta(test_index), fd_here, analytic_here));
    end
    if i==20, fprintf('Gradient test passed for hid_to_class. '); end
    if i==100, fprintf('Gradient test passed for input_to_hid. '); end
  end
  fprintf('Gradient test passed. That means that the gradient that your code computed is within 0.001%% of the gradient that the finite difference approximation computed, so the gradient calculation procedure is probably correct (not certainly, but probably).\n');
end