function bnet2 = dbnSetup3(LM)
% HMM specification:
% HMM for automatic chord estimation backend (one integrated model)
% 1 -> 3 -> 5 -> ...
% |    |    |
% v    v    v
% 2    4    6    ...
%
% Ch = chord progression
% Cd = chordogram
% Ch(i-1) -> Ch(i) (Hidden states)
%   |          |
%   |          |
%   v          v
% Cd(i-1)    Cd(i) (Observable states)
%

ss = 2; % ss = slice size
intra = zeros(ss);
intra(1,2) = 1;
inter = zeros(ss);
inter(1,1) = 1;
eclass1 = [1 2];
eclass2 = [3 2];
eclass = [eclass1 eclass2];

H = size(LM,1);
O = H; % 12 for uppergram and 12 for basegram
ns = [H O]; % one chord emit one saliece
dnodes = 1; % discrete node class
hnodes = 1; % hidden node class
cnodes = 2; % continous node class
onodes = 2; % observable node class
bnet2 = mk_dbn(intra, inter, ns, 'discrete', dnodes, 'observed', cnodes,...
    'eclass1', eclass1, 'eclass2', eclass2);

% set CPDs: CPD{1} <- prior; CPD{2} <- emission; CPD{3} <- transition

% prior probabilities
prior = normalise(ones(1,H)); % uniform distribution

% emission probabilities
mu = eye(O);

sigma = zeros(O,O,H);
for i = 1:H
    sigma(:,:,i) = 0.1.*eye(O);
end

% transition probabilities
% not only self transtional prob is different from others
transmat = mk_stochastic(LM);

% set bayesian net's CPDs
bnet2.CPD{1} = tabular_CPD(bnet2, 1, prior);
bnet2.CPD{2} = gaussian_CPD(bnet2, 2, 'mean', mu, 'cov', sigma);
bnet2.CPD{3} = tabular_CPD(bnet2, 3, transmat);
