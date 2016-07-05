function csr = computeCSR(gtrootgram, gttreblegram, gtsegments, cprootgram, cptreblegram, cpsegments, TD)

CD = 0; % bass correct duration
for i = 1:1:length(gtrootgram)
    st = gtsegments(i);
    et = gtsegments(i+1);
    boundst = locatebound(st,cpsegments, 'st');
    if boundst(1) == 0
        continue;
    end
    bst = cprootgram(boundst(1));
    tst = cptreblegram(boundst(1));
    boundet = locatebound(et,cpsegments, 'et');
    
    cpboundset = [st cpsegments(boundst(2):boundet(1)) et];
    cprootset = [bst cprootgram(boundst(2):boundet(1))];
    cptrebleset = [tst cptreblegram(boundst(2):boundet(1))];
    
    gtroot = gtrootgram(i);
    gttreble = gttreblegram(i);
    for j = 1:1:length(cpboundset) - 1
        if (cprootset(j) == gtroot) && (cptrebleset(j) == gttreble)
            CD = CD + cpboundset(j+1) - cpboundset(j);
        end
    end
end
csr = CD / TD;