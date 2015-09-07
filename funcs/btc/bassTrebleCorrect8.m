% recompute bass-treble using the trained neural network param nn2(data-J-12-key.mat,120,544,1000,1)-71.6

function [rootgram, bassgram, treblegram] = bassTrebleCorrect8(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode)


nslices = size(rootgram,2);
load('nn2(data-J-12-key.mat,120,544,1000,1)-71.6.mat');
load('chordnames.mat');
chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];

for j = 1:nslices
    bd1 = bdrys(j);
    bd2 = bdrys(j+1);
    hsrbdb = bd1:bd2;
    bgbdb = basegram(:,hsrbdb);
    ugbdb = uppergram(:,hsrbdb);
    bj = median(bgbdb,2);
    uj = median(ugbdb,2);
    
    in = normalizeGram([bj;uj],inf);
    out = predictNN2(Theta1, Theta2, Theta3, in');
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