% compute a 12 dimensional basegram (only keep at most three pitches)
function basegram = computeBasegram(ingram)

ntones = size(ingram, 1);
nchords = size(ingram, 2);
basegram = zeros(12,nchords);

for j = 1:1:nchords
    count = 0;
    bgram = zeros(12,1);
    for i = 1:1:ntones
        % find out the lowest salience
        if ingram(i,j) > 0
            % revise the order to be starting from C
            bgram(pitchTranspose(i,9)) = ingram(i,j);
%             bgram(pitchTranspose(i,9)) = (3 - count) * Shv(i,j);
            count = count + 1;
            if count == 3
                break;
            end
        end
    end
    basegram(:,j) = bgram;
end