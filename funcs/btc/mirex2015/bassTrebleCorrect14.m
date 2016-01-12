% recompute the whole sequence using another probabilistic model:
% note that the acoustic model has no bias units
% acoustic model - rbm2_bias(120,544,277,0.02,1000,10000,data-JB-12,0)-nn2_bias(120,544,277,1000,1,init_model,data-JB-12)

function [rootgram, bassgram, treblegram] = bassTrebleCorrect14(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode)


nslices = size(rootgram,2);
load('rbm2_bias(120,544,277,0.02,1000,10000,data-JB-12,0)-nn2_bias(120,544,277,1000,1,init_model,data-JB-12).mat');
load('chordnames.mat');
chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];

Theta1 = model.input_to_hid_1;
Theta2 = model.hid_1_to_hid_2;
Theta3 = model.hid_2_to_class;

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
