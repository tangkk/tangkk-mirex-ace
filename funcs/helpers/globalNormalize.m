% global normalize a matrix
function out = globalNormalize(in)

out = in ./ max(max(in));