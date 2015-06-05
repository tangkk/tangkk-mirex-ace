function S = specRollOn(S, sr)

nslices = size(S,2);
ntones = size(S,1);

for j = 1:nslices
    col = S(:,j);
    total = sum(col);
    cum = 0;
    for i = 1:ntones
        cum = cum + col(i);
        if cum > sr*total
            col(1:i) = 0;
            S(:,j) = col;
            break;
        end
    end
end