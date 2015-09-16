function ret = d_loss_by_d_model_2(model, data, wd_coefficient)
  lambda = wd_coefficient;
  Theta1 = model.input_to_hid_1;
  Theta2 = model.hid_1_to_hid_2;
  Theta3 = model.hid_2_to_class;
  X = data.inputs;
  y = data.targets;
  m = size(y,2);
  
  a1 = X;
  z2 = Theta1*a1;
  a2 = logistic(z2);
  z3 = Theta2*a2;
  a3 = logistic(z3);
  z4 = Theta3*a3;
  
  a4norm = log_sum_exp_over_rows(z4);
  loga4prob = z4 - repmat(a4norm, [size(z4, 1), 1]);
  a4 = exp(loga4prob);
  
  delta4 = a4 - y;
  delta3 = (Theta3'*delta4).*logisticGradient(z3);
  delta2 = (Theta2'*delta3).*logisticGradient(z2);
  
  Theta1_grad = delta2*a1';
  Theta2_grad = delta3*a2';
  Theta3_grad = delta4*a3';
  Theta1_grad = Theta1_grad ./ m + (lambda./m) .* Theta1;
  Theta2_grad = Theta2_grad ./ m + (lambda./m) .* Theta2;
  Theta3_grad = Theta3_grad ./ m + (lambda./m) .* Theta3;
  
  ret.input_to_hid_1 = Theta1_grad;
  ret.hid_1_to_hid_2 = Theta2_grad;
  ret.hid_2_to_class = Theta3_grad;
end