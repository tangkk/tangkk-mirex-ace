function [rootgram, bassgram, treblegram] = dbnInference(bnet, chordmode, basegram, uppergram)

% inference
T = size(basegram,2);
nct = size(chordmode,2);
rootgram = zeros(1,T);
bassgram = zeros(1,T);
treblegram = zeros(1,T);
jengine = smoother_engine(jtree_2TBN_inf_engine(bnet));
evidence = cell(2,T);
for i  = 1:1:T
    bg = basegram(:,i);
    ug = uppergram(:,i);
    bass = bg(1); bweight = bg(2);
    evb = zeros(12,1); evb(bass) = bweight;
    evu = ug;
    ev = [evb;evu];
    evidence(2,i) = num2cell(ev,1);
end
[jengine,llj] = enter_evidence(jengine, evidence);
mpe = find_mpe(jengine, evidence);

for i = 1:1:T
    cn = cell2num(mpe(1,i));
    bn = ceil(cn/(nct-1));
    tn = mod(cn,nct-1)+1;
    tstr = chordmode{2,tn};
    rn = bass2root(bn, tstr);
    rootgram(i) = rn;
    bassgram(i) = bn;
    treblegram(i) = tn;
end