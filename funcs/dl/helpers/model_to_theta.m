function ret = model_to_theta(model)
  % This function takes a model (or gradient in model form), and turns it into one long vector. See also theta_to_model.
  input_to_hid_transpose = transpose(model.input_to_hid);
  hid_to_class_transpose = transpose(model.hid_to_class);
  ret = [input_to_hid_transpose(:); hid_to_class_transpose(:)];
end