function outgram = denormalizeGram(ingram, normVec)

mat = repmat(normVec,size(ingram,1),1);
outgram = ingram .* mat;