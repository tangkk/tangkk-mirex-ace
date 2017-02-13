function [rootgram, bassgram, treblegram, bdrys] = nn4Decode_get(chordmode, tline, model, beparam, bdrys)

x = [strrep(tline(1:end-4),'/','-'), '-ns', '-', 'songwise.mat'];
y = [model, '=', x];

load(['./data/y_preds/',y]);
y_preds = y_preds';

load('chordnames-inv.mat');
chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];

nslices = size(bdrys,2)-1;

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
