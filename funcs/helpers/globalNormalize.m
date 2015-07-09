% global normalize a matrix
function [out, maxin] = globalNormalize(in)

maxin = max(max(in));
out = in ./ maxin;