% recompute the whole sequence using another probabilistic model:
% acoustic model - mlp-J6seg-ch-inv.pkl-1000
 
function [rootgram, bassgram, treblegram] = bassTrebleCorrect30(basegram, uppergram, bdrys, chordmode)

rootgram = [];
bassgram = [];
treblegram = [];

nslices = size(bdrys,2)-1;
load('chordnames-inv.mat');
chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
nseg = 6;

% step 1, generate the 6seg samples from basegram and uppergram - store X
X = zeros(1,24*nseg);
for j = 1:nslices
    sb = bdrys(j);
    eb = bdrys(j+1);
    smb = basegram(:,sb:eb);
    smu = uppergram(:,sb:eb);
    sm = [smb;smu];
    smnseg = zeros(24,nseg);

    % seperate each segment into nseg sections (along time axis) and take average upon the
    % segments
    lenseg = eb-sb+1; % length of the whole segment
    lensec = max(floor(lenseg / nseg),1); % length of each section
    for i = 1:nseg
        smsec = mean(sm(:,min((i-1)*lensec+1,lenseg): min(i*lensec,lenseg)),2);
        smnseg(:,i) = smsec;
    end
    tcase = smnseg(:);
    X(j,:) = tcase';
end

save('./data/temp/X.mat','X');

% execute python prediction script to predict X
% first argument is input path
% second argument is model path
% third argument is nntype
python nn/predict.py ./data/temp/X.mat ./data/model/mlp-J6seg-ch-inv-1000.pkl mlp inv
% the output of the process is saved to ./data/temp/y_prob.mat and
% ./data/temp/y_pred.mat
load('./data/temp/y_preds.mat');
y_preds = y_preds';

for j = 1:nslices
    out = y_preds(j);
    chnum = chordnums{out};
    strtoks = strsplit(chnum,':');
    root = str2double(strtoks{1});
    treble = str2double(strtoks{2});
    if root ~= 0 && treble ~= 0
        rootgram(j) = root;
        treblegram(j) = treble;
        bassgram(j) = root2bass(root,chordmode{2,treble});
    else
        rootgram(j) = 0;
        treblegram(j) = 0;
        bassgram(j) = 0;
    end
end