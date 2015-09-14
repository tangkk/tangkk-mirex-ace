function ret = cd1_bias(rbm_w, visible_data)
% <rbm_w> is a matrix of size <number of hidden units> by <number of visible units>
% <visible_data> is a (possibly but not necessarily binary) matrix of size <number of visible units> by <number of data cases>
% The returned value is the gradient approximation produced by CD-1. It's of the same shape as <rbm_w>.
% <visible_state_x> is a (possibly but not necessarily binary) matrix of size <number of visible units> by <number of data cases>
% <hidden_state_x> is a (possibly but not necessarily binary) matrix of size <number of hidden units> by <number of data cases>
    m = size(visible_data,2);
    visible_state_0 =  sample_bernoulli([ones(1,m);visible_data]);
    hidden_state_0 = sample_bernoulli(logistic(rbm_w*visible_state_0));
    visible_state_1 = sample_bernoulli(logistic(rbm_w'*hidden_state_0));
    hidden_state_1 = sample_bernoulli(logistic(rbm_w*visible_state_1));
    
    G0 = configuration_goodness_gradient(visible_state_0, hidden_state_0);
    % original CD-1:
%     G1 = configuration_goodness_gradient(visible_state_1, hidden_state_1);
    % improved CD-1:
    G1 = configuration_goodness_gradient(visible_state_1, logistic(rbm_w*visible_state_1));
    ret = G0 - G1; % (d(w(i,j)) = <vi,hj>^0 - <vi,hj>^1)
%     error('not yet implemented'); 
end
