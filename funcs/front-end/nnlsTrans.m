% use nnls to approximately transcribe the note salience matrix
% given the log-freq note profile E
function Sapx = nnlsTrans(S,E,nnotes)

nslices = size(S,2);
Sapx = zeros(nnotes, nslices);

for j = 1:nslices
    d = S(:,j);
    x = lsqnonneg(E,d);
    Sapx(:,j) = x;
end