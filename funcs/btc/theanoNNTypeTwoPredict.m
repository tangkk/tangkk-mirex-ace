% estimate the sequence using theano based parametric and non-parametric
% 6seg models
 
function [rootgram, bassgram, treblegram] = theanoNNTypeTwoPredict(basegram, uppergram, bdrys, chordmode, model)

rootgram = [];
bassgram = [];
treblegram = [];

nslices = size(bdrys,2)-1;
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

% extract info from model
if ~isempty(strfind(model,'-inv-')) || ~isempty(strfind(model,'Inv'))
    invtype = 'inv';
    load('chordnames-inv.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-noinv-')) || ~isempty(strfind(model,'Noinv'))
    invtype = 'noinv';
    load('chordnames-noinv.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
end

if isempty(strfind(model,'.txt')) % not ensemble model
    if ~isempty(strfind(model,'mlp'))
        nntype = 'mlp';
    elseif ~isempty(strfind(model,'dbn'))
        nntype = 'dbn';
    elseif ~isempty(strfind(model,'blstm'))
        nntype = 'blstm';
    elseif ~isempty(strfind(model,'lstm'))
        nntype = 'lstm';
    elseif ~isempty(strfind(model,'knn'))
        nntype = 'knn';
    elseif ~isempty(strfind(model,'svm'))
        nntype = 'svm';
    end
    % execute python prediction script to predict X
    pythoncmd = {'nn/predict.py','./data/temp/X.mat',['./data/model/' model],nntype,invtype};
else % ensemble model
    pythoncmd = {'nn/enspredict.py','./data/temp/X.mat',['./data/model/' model]};
end

python(pythoncmd)


% the output of the process is saved to ./data/temp/y_probs.mat and
% ./data/temp/y_preds.mat
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