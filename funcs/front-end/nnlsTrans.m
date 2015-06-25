% use nnls to approximately transcribe the note salience matrix
% given the log-freq note profile E
function Sapx = nnlsTrans(S,E,nnotes)

nslices = size(S,2);
ntones = size(S,1);
Sapx = zeros(nnotes, nslices);

for j = 1:nslices
    d = S(:,j);
    
    % locate the significant starting index (rather than starting at 1)
    itone = 1;
    for i = 1:ntones
        if d(i) > 0
            itone = i;
            % make si % 3 = 1
            if mod(itone,3) == 0
                itone = itone - 2;
            elseif mod(itone,3) == 2
                itone = itone - 1;
            end
            break;
        end
    end
    inote = (itone+2)/3;
    
    dd = d(itone:end);
    Ed = E(itone:end,inote:end);
    x = lsqnonneg(Ed,dd);
    Sapx(inote:end,j) = x;
end