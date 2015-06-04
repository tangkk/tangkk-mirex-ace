% onset filter (roughly detect the note onsets)
function So = noteOnsetFilter(S, ot, wo)

sizeS = size(S);
So = zeros(sizeS(1), sizeS(2)); % onset matrix
for i = 1:1:sizeS(1)
    for j = 1:1:sizeS(2)
        hi = 0;
        if j == 1
            hi = max(S(i,j:min(j+10,sizeS(2))));
        else
            if S(i,j) > 0 && S(i,j-1) == 0
                hi = max(S(i,j:min(j+wo,sizeS(2))));
            end
        end
        if hi > ot
            So(i,j:min(j+wo,sizeS(2))) = hi;
        end
    end
end