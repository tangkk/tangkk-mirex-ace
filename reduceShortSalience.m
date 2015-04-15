function Sout = reduceShortSalience(Sin,wgmax,st,bb)

Sout = Sin;
for i = 1:1:bb*3
    trackidx = 1;
    islight = 0;
    for j = 1:1:size(Sin,2)
        if Sin(i,j) <= st
            if islight == 1;
                lenLight = j - trackidx;
                if lenLight <= wgmax
                    Sout(i,trackidx:j-1) = zeros(1,lenLight);
                end
            end
            trackidx = j;
            islight = 0;
        else
            islight = 1;
        end
    end
end