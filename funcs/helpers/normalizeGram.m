% normalize the input whatever gram, note that the gram should be in
% column vector format
function outgram = normalizeGram(ingram, p)

outgram = zeros(size(ingram));

for j = 1:size(ingram,2)
    vec = ingram(:,j);
    nVec = norm(vec,p);
    if nVec ~= 0
        outgram(:,j) = vec ./ nVec;
    end
end

