function ret = model_to_theta_2(model)
  % This function takes a model (or gradient in model form), and turns it into one long vector. See also theta_to_model.
  input_to_hid_1_transpose = transpose(model.input_to_hid_1);
  hid_1_to_hid_2_transpose = transpose(model.hid_1_to_hid_2);
  hid_2_to_class_transpose = transpose(model.hid_2_to_class);
  ret = [input_to_hid_1_transpose(:); hid_1_to_hid_2_transpose(:); hid_2_to_class_transpose(:)];
end