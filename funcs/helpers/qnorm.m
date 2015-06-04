function s = qnorm(inmat, varargin)
dim = 1;
if nargin > 1
    q = varargin{1};
    if nargin > 2
        dim = varargin{2};
    end
else
    q = 2;
end
if ~(q == Inf)
    s = sum(inmat.^q,dim).^(1/q);
else
    s = max(inmat,[],dim);
end