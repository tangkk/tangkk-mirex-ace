function visualizeChordMPE(mpe, chordmode)

nct = size(chordmode,2);
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
display(cp);