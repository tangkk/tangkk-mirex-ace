function [outmat, scale] = qnormalise(inmat, varargin)
% qnormalise(inmat, q, dim) returns the field inmat normalised by the q
% norm over dimension dim
dim = 1;
if nargin > 1
    q = varargin{1};
    if nargin > 2
        dim = varargin{2};
    end
else
    q = 2;
end
sizeInmat = size(inmat);
nDim = length(sizeInmat);
repeatpattern = [ones(1,dim-1) sizeInmat(dim) ones(1,nDim-dim)];
scale = qnorm(inmat, q, dim);
outmat = inmat ./ repmat(scale, repeatpattern);
