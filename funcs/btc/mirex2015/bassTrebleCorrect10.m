% recompute the whole sequence using another probabilistic model:
% acoustic model - nn2(data-J-12-key.mat,120,544,1000,1)-71.6
% language model - LM-B

function [rootgram, bassgram, treblegram] = bassTrebleCorrect10(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode)


nslices = size(rootgram,2);
load('nn2(data-J-12-key.mat,120,544,1000,1)-71.6.mat');
load('LM-B.mat');
load('chordnames.mat');
chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
nchords = length(chordnums);

chordogram = zeros(nchords,nslices); % create a 1*nslices chordogram
for j = 1:nslices
    bd1 = bdrys(j);
    bd2 = bdrys(j+1);
    hsrbdb = bd1:bd2;
    bgbdb = basegram(:,hsrbdb);
    ugbdb = uppergram(:,hsrbdb);
    bj = median(bgbdb,2);
    uj = median(ugbdb,2);
    
    X = normalizeGram([bj;uj],inf);
    
    m = size(X', 1);
    h1 = sigmoid([ones(m, 1) X'] * Theta1');
    h2 = sigmoid([ones(m, 1) h1] * Theta2');
    h3 = sigmoid([ones(m, 1) h2] * Theta3');
    
    chordogram(:,j) = h3';
end

% setup an 1D -> nchordC HMM (1-dim discrete node -> nchord-dim continous node)
bnet3 = dbnSetup3(LM); % LM is the language model
[rootgram, bassgram, treblegram] = dbnInference3(bnet3, chordnums, chordmode, chordogram);

