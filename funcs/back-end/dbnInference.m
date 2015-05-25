function cp = dbnInference(bnet, chordmode, basegram, uppergram)

% inference
T = size(basegram,2);
nct = size(chordmode,2);
jengine = smoother_engine(jtree_2TBN_inf_engine(bnet));
evidence = cell(2,T);
for i  = 1:1:T
    bg = basegram(:,i);
    ug = uppergram(:,i);
    bass = bg(1); bweight = bg(3);
    evb = zeros(12,1); evb(bass) = bweight;
    evu = ug;
    ev = [evb;evu];
    evidence(2,i) = num2cell(ev,1);
end
[jengine,llj] = enter_evidence(jengine, evidence);
mpe = find_mpe(jengine, evidence);

cp = cell(1,size(mpe,2));
for i = 1:1:length(cp)
    cn = cell2num(mpe(1,i));
    bn = ceil(cn/(nct-1)); % bass number
    tstr = chordmode{2,mod(cn,nct-1)+1};
    rn = bass2root(bn, tstr);
    rstr = num2note(rn);
    chstr = strcat(rstr, tstr);
    cp{i} = chstr;
end