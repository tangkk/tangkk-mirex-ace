function outgram = computeChromagram(ingram)

ntones = size(ingram, 1);
nchords = size(ingram, 2);
outgram = zeros(12,nchords);

for k = 1:1:ntones/12
    outgram = outgram + ingram(12*(k-1)+1:1:12*k,:);
end

outgram = [outgram(4:end,:) ; outgram(1:3,:)];