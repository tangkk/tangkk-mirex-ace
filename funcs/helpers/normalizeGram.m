% normalize the input whatever gram, note that the gram should be in
% column vector format
function outgram = normalizeGram(ingram, p)

outgram = zeros(size(ingram));

if p == 0
    outgram = globalNormalize(ingram);
else
    for j = 1:size(ingram,2)
        vec = ingram(:,j);
        normVec = norm(vec,p);
        if normVec ~= 0
            outgram(:,j) = vec ./ normVec;
        end
    end
end

