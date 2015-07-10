% compute a 12 dimensional basegram (only keep at most three pitches)
function basegram = computeBasegram(ingram)

ntones = size(ingram, 1);
nslices = size(ingram, 2);
basegram = zeros(2,nslices);

for j = 1:1:nslices
    for i = 1:1:ntones
        % find out the lowest salience
        if ingram(i,j) > 0
            % revise the order to be starting from C
            basegram(1,j) = pitchTranspose(i,9);
            basegram(2,j) = ingram(i,j);
            break;
        end
    end
end