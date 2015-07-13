function rco = computeRCO(gtbassgram, gttreblegram, gtboundaries, bassgram, treblegram, boundaries, TD)

CD = 0; % bass correct duration
for i = 1:1:length(gtbassgram)
    st = gtboundaries(i);
    et = gtboundaries(i+1);
    boundst = locatebound(st,boundaries, 'st');
    bst = bassgram(boundst(1));
    tst = treblegram(boundst(1));
    boundet = locatebound(et,boundaries, 'et');
%     bet = bassgram(boundet(1));
%     tet = treblegram(boundet(1));
    boundset = [st boundaries(boundst(2):boundet(1)) et];
    bassset = [bst bassgram(boundst(2):boundet(1))];
    trebleset = [tst treblegram(boundst(2):boundet(1))];
    
    gtbass = gtbassgram(i);
    gttreble = gttreblegram(i);
    for j = 1:1:length(boundset) - 1
        if (bassset(j) == gtbass||bassset(j) == 0 || gtbass==0) &&...
           (trebleset(j) == gttreble || trebleset(j) == 3 || gttreble == 3||trebleset(j) == 0 || gttreble == 0)
            CD = CD + boundset(j+1) - boundset(j);
        end
    end
end
rco = CD / TD;