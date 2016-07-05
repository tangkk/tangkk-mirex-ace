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
    load('chordnames-inv.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-noinv-')) || ~isempty(strfind(model,'Noinv'))
    invtype = 'noinv';
    load('chordnames-noinv.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-no7-')) || ~isempty(strfind(model,'No7'))
    invtype = 'no7';
    load('chordnames-no7.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-jazz-'))
    invtype = 'jazz';
    load('chordnames-jazz.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-full-'))
    invtype = 'full';
    load('chordnames-full.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-Mm-'))
    invtype = 'Mm';
    load('chordnames-Mm.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
end

if ~isempty(strfind(model,'bctc'))
    nntype = 'bctc';
elseif ~isempty(strfind(model,'ctc'))
    nntype = 'ctc';
elseif ~isempty(strfind(model,'blstmrnn'))
    nntype = 'blstmrnn';
elseif ~isempty(strfind(model,'lstmrnn'))
    nntype = 'lstmrnn';
end

if ~isempty(strfind(model,'sg'))
    nntype = [nntype 'sg'];
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

[rootgram, bassgram, treblegram, bdrys] = combineSameChords_nocomp(rootgram,...
    bassgram, treblegram, bdrys);

[rootgram, bassgram, treblegram, bdrys] = eliminateShortChords(rootgram,...
    bassgram, treblegram, bdrys, beparam.grainsize);

display('chord progression done...');
