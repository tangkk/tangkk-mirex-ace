function S = specRollOn(S, sr)

nslices = size(S,2);
ntones = size(S,1);

for j = 1:nslices
    col = S(:,j);
    energysum = sum(col.^2);
    cum = 0;
    for i = 1:ntones
        cum = cum + col(i).^2;
        if cum < sr*energysum
            S(i,j) = 0;
        else
            break;
        end
    end
end