function assert(pred, str, v1, v2, v3, v4)
% ASSERT Raise an error if the predicate is not true.
% assert(pred, string)

if nargin<2, str = ''; end
if nargin>=2

    if ~pred
      s = sprintf('assertion violated: %s', str);
      error(s);
    end
end
