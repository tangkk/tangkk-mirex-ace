function uppergram = computeUppergram(Shv)

sizeShv = size(Shv);
ntones = sizeShv(1);
nchords = sizeShv(2);
uppergram = zeros(12,nchords);

for k = 1:1:ntones/12
    uppergram = uppergram + Shv(12*(k-1)+1:1:12*k,:);
end

uppergram = [uppergram(4:end,:) ; uppergram(1:3,:)];

% normalize uppergram
uppergram = normalizeGram(uppergram);