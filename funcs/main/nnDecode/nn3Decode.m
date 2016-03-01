function [rootgram, bassgram, treblegram, bdrys] = nn3Decode(chordmode, model, beparam, rawbasegram, rawuppergram, bdrys)

display('chord decoding...');

rootgram = [];
bassgram = [];
treblegram = [];

nslices = size(bdrys,2)-1;

% step 1, combine rawbasegram and rawuppergram
X = [rawbasegram;rawuppergram]';

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
elseif ~isempty(strfind(model,'-no7-')) || ~isempty(strfind(model,'No7'))
    invtype = 'no7';
    nchords = 73;
    load('chordnames-no7.mat');
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

if beparam.enChordGestalt
[rootgram, bassgram, treblegram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, bdrys, beparam, chordmode);
end

display('chord progression done...');
