function basegram = computeBasegram(Shv)

sizeShv = size(Shv);
ntones = sizeShv(1);
nchords = sizeShv(2);
basegram = zeros(2,nchords);

for j = 1:1:nchords
    for i = 1:1:ntones
        % find out the lowest salience
        if Shv(i,j) > 0
            % revise the order to be starting from C
            basegram(1,j) = pitchTranspose(i,9);
            basegram(2,j) = Shv(i,j);
            break;
        end
    end
end