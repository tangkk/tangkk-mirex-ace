function S = reduceShortSalience(S, wgmax, st, bb, isPre)

if isPre
    upperbound = bb*3;
else
    upperbound = size(S,1);
end

for i = 1:1:upperbound
    trackidx = 1;
    islight = 0;
    for j = 1:1:size(S,2)
        if S(i,j) <= st
            if islight == 1;
                lenLight = j - trackidx;
                if lenLight <= wgmax
                    S(i,trackidx:j-1) = zeros(1,lenLight);
                end
            end
            trackidx = j;
            islight = 0;
        else
            islight = 1;
        end
    end
end