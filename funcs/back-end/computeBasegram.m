% compute a 12 dimensional basegram (only keep at most three pitches)
function basegram = computeBasegram(Shv)

sizeShv = size(Shv);
ntones = sizeShv(1);
nchords = sizeShv(2);
basegram = zeros(12,nchords);


for j = 1:1:nchords
    count = 0;
    bgram = zeros(12,1);
    for i = 1:1:ntones
        % find out the lowest salience
        if Shv(i,j) > 0
            % revise the order to be starting from C
            bgram(pitchTranspose(i,9)) = Shv(i,j);
            count = count + 1;
            if count == 3
                break;
            end
        end
    end
    if norm(bgram) > 0
        bgram = bgram./norm(bgram);
    end
    basegram(:,j) = bgram;
end