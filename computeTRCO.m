function trco = computeTRCO(gttreblegram, gtboundaries, treblegram, boundaries, TD)

TCD = 0; % treble correct duration
for i = 1:1:length(gttreblegram)
    st = gtboundaries(i);
    et = gtboundaries(i+1);
    boundst = locatebound(st,boundaries, 'st');
    tst = treblegram(boundst(1));
    boundet = locatebound(et,boundaries, 'et');
%     tet = treblegram(boundet(1));
    boundset = [st boundaries(boundst(2):boundet(1)) et];
    trebleset = [tst treblegram(boundst(2):boundet(1))];
    
    % note that the treble == 0 case are rare, so it won't affect much of
    % the performance, and treble == 3 case are not rare but it normally
    % reflects the find details of a chord thus we accept it for this
    % version
    gttreble = gttreblegram(i);
    for j = 1:1:length(trebleset)
        if trebleset(j) == gttreble || trebleset(j) == 3 || gttreble == 3 ||...
            trebleset(j) == 0 || gttreble == 0
            TCD = TCD + boundset(j+1) - boundset(j);
        end
    end
end
trco = TCD / TD;
