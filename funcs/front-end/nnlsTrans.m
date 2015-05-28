% use nnls to approximately transcribe the note salience matrix
% given the log-freq note profile E
function Sapx = nnlsTrans(S,E,toneratio)

Sapx = zeros(size(S,1)/toneratio, size(S,2));
nslices = size(S,2);
for j = 1:nslices
    d = S(:,j);
    x = lsqnonneg(E,d);
    Sapx(:,j) = x;
end