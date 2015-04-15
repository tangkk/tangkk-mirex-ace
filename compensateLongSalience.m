function Sout = compensateLongSalience(Sin, wgmax, st, bb)

Sout = Sin;
for i = 1:1:bb*3
    trackidx = 1;
    isblank = 0;
    wpg = 0;
    for j = 1:1:size(Sin,2)
        if Sin(i,j) > st
            % compensate the gestalt
            if isblank == 1
                lenBlank = j - trackidx;
                if lenBlank <= min(wgmax, wpg)
                    Sout(i,trackidx:j-1) = mean(Sin(i,max(trackidx-wpg,1):trackidx))*ones(1,lenBlank);
                    wpg = wpg + lenBlank;
                else
                    wpg = 0;
                end
            end
            isblank = 0;
            wpg = wpg + 1;
            trackidx = j;
        else
            isblank = 1;
        end
    end
end