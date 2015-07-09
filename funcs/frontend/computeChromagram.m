function outgram = computeChromagram(ingram)

ntones = size(ingram, 1);
nslices = size(ingram, 2);
outgram = zeros(12,nslices);

for k = 1:12
    outgram(k,:) = outgram(k,:) + sum(ingram(k:12:end,:),1);
end

outgram = [outgram(4:end,:) ; outgram(1:3,:)];