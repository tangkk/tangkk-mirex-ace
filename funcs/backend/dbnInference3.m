function [rootgram, bassgram, treblegram] = dbnInference3(bnet, chordnums, chordmode, chordogram)

T = size(chordogram,2);
rootgram = zeros(1,T);
bassgram = zeros(1,T);
treblegram = zeros(1,T);
jengine = hmm_inf_engine(bnet);
evidence = cell(2,T);
for j  = 1:1:T
    cd = chordogram(:,j);
    evidence(2,j) = num2cell(cd,1);
end
[jengine,~] = enter_evidence(jengine, evidence);
mpe = find_mpe(jengine, evidence);

for j = 1:1:T
    cn = cell2num(mpe(1,j));
    chnum = chordnums{cn};
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