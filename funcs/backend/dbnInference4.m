% for NN use
function [rootgram, bassgram, treblegram] = dbnInference4(bnet, chordmode, chordogram, nchords)

T = size(chordogram,2);
rootgram = zeros(1,T);
bassgram = zeros(1,T);
treblegram = zeros(1,T);
jengine = hmm_inf_engine(bnet);
% jengine = smoother_engine(jtree_2TBN_inf_engine(bnet));
evidence = cell(2,T);
for i  = 1:1:T
    cd = chordogram(:,i);
    evidence(2,i) = num2cell(cd,1);
end
[jengine,llj] = enter_evidence(jengine, evidence);
mpe = find_mpe(jengine, evidence);

if nchords == 277
    load('chordnames-inv.mat');
elseif nchords == 61
    load('chordnames-noinv.mat');
end
chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
for j = 1:T
    out = cell2num(mpe(1,j));
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
% for i = 1:1:T
%     cn = cell2num(mpe(1,i));
%     if cn == nchords
%         rn = 0;
%         bn = 0;
%         tn = 0;
%     else
%         bn = ceil(cn/nct);
%         tn = mod(cn - 1,nct)+1;
%         tstr = chordmode{2,tn};
%         rn = bass2root(bn, tstr); 
%     end
%     rootgram(i) = rn;
%     bassgram(i) = bn;
%     treblegram(i) = tn;
% end