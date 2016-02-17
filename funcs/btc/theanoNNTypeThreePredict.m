% estimate the sequence using the Theano (B)LSTM based parametric song
% model
 
function [rootgram, bassgram, treblegram] = theanoNNTypeThreePredict(basegram, uppergram, bdrys, chordmode, model)

rootgram = [];
bassgram = [];
treblegram = [];

nslices = size(bdrys,2)-1;

% step 1, combine basegram and uppergram
X = [basegram;uppergram]';

save('./data/temp/X.mat','X');

% extract info from model
if ~isempty(strfind(model,'-inv-')) || ~isempty(strfind(model,'Inv'))
    invtype = 'inv';
    nchords = 277;
    load('chordnames-inv.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-noinv-')) || ~isempty(strfind(model,'Noinv'))
    invtype = 'noinv';
    nchords = 61;
    load('chordnames-noinv.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
end

if ~isempty(strfind(model,'bctc'))
    nntype = 'bctc';
elseif ~isempty(strfind(model,'ctc'))
    nntype = 'ctc';
end
pythoncmd = {'nn/predict.py','./data/temp/X.mat',['./data/model/' model],nntype,invtype};
python(pythoncmd)


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

% load('./data/temp/y_probs.mat');
% chordogram = y_probs';
% dbn2param = struct(...
%     'mu', 1,...
%     'sigma', 0.1,...
%     'selfTrans', 1e12);
% bnet4 = dbnSetup4(dbn2param, nchords);
% [chordogram, ~] = normalizeGram(chordogram, inf);
% [rootgram, bassgram, treblegram] = dbnInference4(bnet4, chordmode, chordogram, nchords);

