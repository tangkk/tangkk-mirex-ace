% normalize the input whatever gram, note that the gram should be in
% column vector format
function [outgram, normVec] = normalizeGram(ingram, p)

outgram = zeros(size(ingram));
normVec = zeros(1,size(ingram,2));

if p == 0
    [outgram, normm] = globalNormalize(ingram);
    normVec = ones(size(ingram,2)) .* normm;
else
    for j = 1:size(ingram,2)
        v = ingram(:,j);
        normv = norm(v,p);
        normVec(j) = normv;
        if normv ~= 0
            outgram(:,j) = v ./ normv;
        end
    end
end

