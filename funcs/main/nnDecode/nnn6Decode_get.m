% work with TheanoNN
function [rootgram, bassgram, treblegram] = nnn6Decode_get(tline, model, nseg)

x = [strrep(tline(1:end-4),'/','-'), '-ns', '-', num2str(nseg), 'seg.mat'];
y = [model, '|', x];

load(['./data/y_preds/',y]);
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

display('chord progression done...');
