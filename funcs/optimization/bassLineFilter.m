function Sb = bassLineFilter(S, bt, wb, cb)
sizeS = size(S);
Sb = zeros(1, sizeS(2)); % bassline vector
for j = 1:1:sizeS(2)
    for i = 1:1:sizeS(1)
        if S(i,j) > bt
            Sb(j) = i;
            break;
        end
        if i == sizeS(1) % continue the bound if nothing found
            if j > 1
                Sb(j) = Sb(j-1);
            end
        end
    end
    if j > 1
        if Sb(j) == Sb(j-1)
            cb = cb+1;
        else
            if cb < wb % if so, gestalize the outliers
                Sb(j - cb:j-1) = Sb(max(j-cb-1,1));
            end
            cb = 1;
        end
    end
end