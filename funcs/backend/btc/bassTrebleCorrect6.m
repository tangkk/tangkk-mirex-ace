% recompute bass-treble using the trained neural network

function [rootgram, bassgram, treblegram] = bassTrebleCorrect6(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode)


nslices = size(rootgram,2);
load('nnparam.mat');
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
    
    in = [bj;uj];
    out = predictnn(Theta1, Theta2, in');
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