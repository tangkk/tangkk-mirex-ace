function uppergram = computeUppergram(ingram)

ntones = size(ingram, 1);
nslices = size(ingram, 2);
uppergram = zeros(12,nslices);

for k = 1:1:ntones/12
    uppergram = uppergram + ingram(12*(k-1)+1:1:12*k,:);
end

uppergram = [uppergram(4:end,:) ; uppergram(1:3,:)];