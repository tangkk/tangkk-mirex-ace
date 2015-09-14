function ret = d_loss_by_d_model(model, data, wd_coefficient)
  lambda = wd_coefficient;
  Theta1 = model.input_to_hid;
  Theta2 = model.hid_to_class;
  X = data.inputs;
  y = data.targets;
  m = size(y,2);
  
  a1 = X;
  z2 = Theta1*a1;
  a2 = logistic(z2);
  z3 = Theta2*a2;
  
  a3norm = log_sum_exp_over_rows(z3);
  loga3prob = z3 - repmat(a3norm, [size(z3, 1), 1]);
  a3 = exp(loga3prob);
  
  delta3 = a3 - y;
  delta2 = (Theta2'*delta3).*logisticGradient(z2);
  
  Theta1_grad = delta2*a1';
  Theta2_grad = delta3*a2';
  Theta1_grad = Theta1_grad ./ m + (lambda) .* Theta1;
  Theta2_grad = Theta2_grad ./ m + (lambda) .* Theta2;
  
  ret.input_to_hid = Theta1_grad;
  ret.hid_to_class = Theta2_grad;
end