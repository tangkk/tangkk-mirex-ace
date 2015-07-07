function S = pcsSuppress(S, pcsT)

for j = 1:size(S,2)
    if sum(S(:,j)) > pcsT
        S(:,j) = 0;
    end
end