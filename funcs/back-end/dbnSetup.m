function bnet = dbnSetup(chordmode)
% HMM specification:
% HMM for automatic chord estimation backend (one integrated model)
% 1 -> 3 -> 5 -> ...
% |    |    |
% v    v    v
% 2    4    6    ...
%
% U = uppergram, B = basegram, Ch = chordogram (chord progression)
% UB = uppergram stacked with basegram 24 dimensional observable vector
% Ch(i-1) -> Ch(i) (Hidden states)
%   |          |
%   |          |
%   v          v
% UB(i-1)    UB(i) (Observable states)
% 
% We could have different trials of the following settings 
%
% Prior probability:
%   1. uniform distribution
%   2. according to Ashley's paper
%   3. learned from data
% Transition probability:
%   1. evenly distributed except for self-transition probability
%   2. assigned according to reasonable musical practice
%   3. learned from data
% Emission probability:
%   every note independently emits salience
%   Gaussian distribution
%   The chord vocabulary similar to those in ''buildChordMode''
%   But this time we consider the weight of the bass
%   the chord bass will have weight 1, otherwise if the bass is a chord note
%   it has a weight of something from 0.5 - 1
ss = 2; % ss = slice size
intra = zeros(ss);
intra(1,2) = 1;
inter = zeros(ss);
inter(1,1) = 1;
eclass1 = [1 2];
eclass2 = [3 2];
eclass = [eclass1 eclass2];

% chord types include those specified by ``chordmode'':
% N
% maj, min,
% maj7, min7, 7,
% maj/3, maj/5, min/b3, min/5,
% maj7/3, maj7/5, maj7/7,
% min7/b3, min7/5, min7/b7,
% 7/3, 7/5, 7/b7
% ...
nct = size(chordmode,2); % number of chord types defined in ``chordmode''
H = (nct - 1) * 12 + 1; % nct - 1 is due to no-chord
O = 24; % 12 for uppergram and 12 for basegram
ns = [H O];
dnodes = 1; % discrete node class
hnodes = 1; % hidden node class
cnodes = 2; % continous node class
onodes = 2; % observable node class
bnet = mk_dbn(intra, inter, ns, 'discrete', dnodes, 'observed', cnodes,...
    'eclass1', eclass1, 'eclass2', eclass2);

% set CPDs: CPD{1} <- prior; CPD{2} <- emission; CPD{3} <- transition

% prior probabilities
% prior = normalise(ones(1,H)); % uniform distribution
% set prior prob according to Ashley's paper
prior = ones(1,H);
for i = 1:1:12
    for j = 2:1:nct
        cstr = chordmode{2,j};
        cidx = (i - 1) * (nct - 1) + j - 1;
        switch cstr
            case 'maj'
                prior(cidx) = prior(cidx) * 10;
            case 'min'
                prior(cidx) = prior(cidx) * 5;
            case '7'
                prior(cidx) = prior(cidx) * 3;
            case 'min7'
                prior(cidx) = prior(cidx) * 2;
            case 'maj7'
                prior(cidx) = prior(cidx) * 2;
        end
    end
end
prior = normalise(prior);

% emission probabilities
% for reference, in mauch's thesis:
% sigma^2 = 0.2 for treble gaussian, sigma^2 = 0.1 for bass gaussian
% mu = 1 for all chord notes, mu = 0 for non-chord notes
%
% For the emission probability of this model
% assuming diagonal covariance matrix (every pitch class is independent)
% the gaussian profiles for bass and treble are stacked together, so that
% the bass profile takes the 1-12 bin, while treble profile takes 13-24 bin
% for treble, we set mu = 1, for chords notes, and mu = 0 for non-chord notes
% sigma^2 = 0.2 for all(subject to further adjustment)
% for bass, we set mu = 1, for both chord bass and other chord-pitch bass
% sigma^2 = 0.1 for chord bass, 0.2 ~ 0.3 for other chord-pitch bass
% for example a Cmaj chord:
% in treble range set mu of C, E, G to 1, and others to 0,
% set every sigma = sqrt(0.2)
% in bass range set mu of C, E, G to 1, and others to 0
% set sigma of E, G to sqrt(0.2), all other sigma to sqrt(0.1)
% as a result:
% Cmaj's mu is [1,0,0,0,1,0,0,1,0,0,0,0;1,0,0,0,1,0,0,1,0,0,0,0]
% Cmaj's sigma is [0.1,0.1,0.1,0.1,0.2,0.1,0.1,0.2,0.1,0.1,0.1,0.1;
%                  0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2]
%
% the mean of the no-chord will be set to all 1s, sigma^2 be all 0.2

mu = zeros(O,H);
sigma = zeros(O,O,H);
% set the mu first, loop over 12 pitch classes and $nct - 1 chord types
% totally there're (nct-1) * 12 mus set in the following loop
% the ``no-chord'' mu is set outside the loop, which will be all 1s.
for i = 1:1:12
    for j = 2:1:nct % except for the no-chord
        ps = [0 chordmode{1,j}];
        muij = zeros(O,1);
        for k = 1:1:length(ps)
            p = pitchTranspose(i,ps(k));
            muij(p) = 1; % bass range
            muij(p+12) = 1; % treble range
        end
        mu(:, (i - 1) * (nct - 1) + j - 1) = muij;
    end
end
mu(:,H) = ones(O,1);

% set the sigma (or sigma^2), similarly, loop over the 12 pitch classes
% and $nct - 1 chord types and set sigma^2 for both treble and bass,
% notice the special consideration for bass, especially the non-chord-bass
sigma2Treble = 0.2;
sigma2CBass = 0.1;
sigma2NCBass = 0.2;
sigma2NoChord = 0.2;
for i = 1:1:12
    for j = 2:1:nct
        ps = [0 chordmode{1,j}];
        sigmaij = [ones(O/2,1)*sqrt(sigma2CBass) ; ones(O/2,1)*sqrt(sigma2Treble)];
        for k = 2:1:length(ps) % only loop non-chord-bass pitch
            p = pitchTranspose(i,ps(k));
            sigmaij(p) = sqrt(sigma2NCBass);
        end
        sigma(:,:,(i - 1) * (nct - 1) + j - 1) = diag(sigmaij);
    end
end
sigma(:,:,H) = eye(O)*sqrt(sigma2NoChord);

% set off-diagonal sigmas (full covariance matrix) 
% fifths(+7) 0.2, third(+4) 0.1, others 0
% sigma13 = 0.02;
% sigma15 = 0.05;
% for i = 1:1:12
%     firstb = i;
%     thirdb = pitchTranspose(firstb,4);
%     fifthb = pitchTranspose(firstb,7);
%     firstt = firstb + 12;
%     thirdt = thirdb + 12;
%     fiftht = fifthb + 12;
%     
%     sigma(firstb,thirdb,:) = sigma13;
%     sigma(thirdb,firstb,:) = sigma13;
%     sigma(firstb,fifthb,:) = sigma15;
%     sigma(fifthb,firstb,:) = sigma15;
%     
%     sigma(firstt,thirdt,:) = sigma13;
%     sigma(thirdt,firstt,:) = sigma13;
%     sigma(firstt,fiftht,:) = sigma15;
%     sigma(fiftht,firstt,:) = sigma15;
% end

% transition probabilities
% not only self transtional prob is different from others
transmat = ones(H,H);
st = 3; % the self transition factor, with larger value yields stronger smoothy.
for i = 1:1:H
    transmat(i,i) = transmat(i,i) * st;
end
transmat = mk_stochastic(transmat);

% set bayesian net's CPDs
bnet.CPD{1} = tabular_CPD(bnet, 1, prior);
bnet.CPD{2} = gaussian_CPD(bnet, 2, 'mean', mu, 'cov', sigma);
bnet.CPD{3} = tabular_CPD(bnet, 3, transmat);
