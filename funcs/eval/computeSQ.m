function sq = computeSQ(gtboundaries, boundaries, BE)

SCN = 0;
TDB = length(boundaries);
for i = 1:1:length(gtboundaries)
    wt = gtboundaries(i);
    if wt <= boundaries(end)
        boundst = locatebound(wt,boundaries, 'wt');
        tbst = boundaries(boundst);
        if wt - tbst(1) < BE || tbst(2) - wt < BE % less than an error bound
            SCN = SCN + 1;
        end
    end
end
sq = SCN / TDB; % correct bounds / total bounds