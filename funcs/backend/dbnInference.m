function [rootgram, bassgram, treblegram] = dbnInference(bnet, chordmode, basegram, uppergram)

% inference
T = size(basegram,2);
nct = size(chordmode,2);
NC = nct * 12 + 1;
rootgram = zeros(1,T);
bassgram = zeros(1,T);
treblegram = zeros(1,T);
% jengine = hmm_inf_engine(bnet);
jengine = smoother_engine(jtree_2TBN_inf_engine(bnet));
evidence = cell(2,T);
for i  = 1:1:T
    bg = basegram(:,i);
    ug = uppergram(:,i);
    evb = bg;
    evu = ug;
    ev = [evb;evu];
    evidence(2,i) = num2cell(ev,1);
end
[jengine,llj] = enter_evidence(jengine, evidence);
mpe = find_mpe(jengine, evidence);

for i = 1:1:T
    cn = cell2num(mpe(1,i));
    if cn == NC
        rn = 0;
        bn = 0;
        tn = 0;
    else
        bn = ceil(cn/nct);
        tn = mod(cn - 1,nct)+1;
        tstr = chordmode{2,tn};
        rn = bass2root(bn, tstr); 
    end
    rootgram(i) = rn;
    bassgram(i) = bn;
    treblegram(i) = tn;
end