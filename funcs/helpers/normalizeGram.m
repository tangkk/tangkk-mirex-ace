% normalize the input whatever gram, note that the gram should be in
% column vector format
function outgram = normalizeGram(ingram)

sizeG = size(ingram);
ny = sizeG(1);

maxG = ones(ny,1)*max(ingram,[],1);
maxG(maxG == 0) = 1;

outgram = ingram ./ maxG;

