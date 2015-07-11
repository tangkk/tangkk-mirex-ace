% correct the bassgram based on the first 1/8 of the harmonic regions of
% the basegram, and update rootgram and treblegram accordingly.
% The dominant bass of the 1/8 of
% the harmonic stable region will be the chord bass of the whole harmonic
% region

function [rootgram, bassgram, treblegram] = bassCorrect(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode)

nslices = size(rootgram,2);

% bass decision boundary = 1/8 of the harmonic stable region, which is a
% reasonable value intuitively. It means the dominant bass of the 1/8 of
% the harmonic stable region will be the chord bass of the whole harmonic
% region
bdb = 1/4;

for j = 1:nslices
    bd1 = bdrys(j);
    bd2 = bdrys(j+1);
    % hsr = bd1:bd2; % harmonic stable region
    hsrbdb = bd1:min(bd1 + floor((bd2 - bd1 + 1)*bdb), bd2);
    bgbdb = basegram(:,hsrbdb);
    ugbdb = uppergram(:, hsrbdb);
    sumbg = sum(bgbdb,2);
    sumug = sum(ugbdb,2);
    % cal new bass
    [~,bass] = max(sumbg);
    % bass correct: only correct those wrong chord inversions cases
    % case1: the recognized result is an inversion but actually it is not
        % subcase1 -> cr != cb && cr = nb, such as (Emaj/5 <- Emaj, Emaj/3 <- Emaj), use
        % basegram to judge
        % subcase2 -> cr != cb && cb = nb, such as (Emaj/5 <- Bmaj, Emaj/3 <- G#min), use
        % uppergram to judge
    % case2: the recognized result is not an inversion but actually it is
        % subcase1 -> cr == cb && cr != nb, such as (Emaj <- Emaj/5, Emaj <- Emaj/3), use
        % basegram to judge
        % subcase2 -> cr == cb && cb = nb, such as (Bmaj <- Emaj/5, G#min <- Emaj/3), use
        % uppergram to judge
    % no other case is considered for now
    % the process assumes the root is correct
    cb = bassgram(j);
    cr = rootgram(j);
    ct = treblegram(j);
    nb = bass;
    if cb ~= 0 && nb ~= cb && cr ~= cb
        % subcase1 -> cr != cb && cr = nb, such as (Emaj/5 <- Emaj, Emaj/3 <- Emaj), use
        % basegram to judge
        if strcmp(chordmode{2,ct},'maj/3') && cr == nb
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj', chordmode);
        end
        if strcmp(chordmode{2,ct},'maj/5') && cr == nb
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj', chordmode);
        end
        % subcase2 -> cr != cb && cb = nb, such as (Emaj/5 <- Bmaj, Emaj/3 <- G#min), use
        % uppergram to judge
        if strcmp(chordmode{2,ct},'maj/3') && cb == nb
            s1 = sumug(pitchTranspose(cb,3)) + sumug(pitchTranspose(cb,8)); % maj/3 upper
            s2 = sumug(pitchTranspose(cb,3)) + sumug(pitchTranspose(cb,7)); % min upper
            if s2 > s1
                rootgram(j) = cb;
                treblegram(j) = tname2tnum('min', chordmode);
            end
        end
        if strcmp(chordmode{2,ct},'maj/5') && cb == nb
            s1 = sumug(pitchTranspose(cb,5)) + sumug(pitchTranspose(cb,9)); % maj/5 upper
            s2 = sumug(pitchTranspose(cb,4)) + sumug(pitchTranspose(cb,7)); % maj upper
            if s2 > s1
                rootgram(j) = cb;
                treblegram(j) = tname2tnum('maj', chordmode);
            end
        end
    end
    
    if cb ~= 0 && nb ~= cb && cr == cb
        % subcase1 -> cr == cb && cr != nb, such as (Emaj <- Emaj/5, Emaj <- Emaj/3), use
        % basegram to judge
        if strcmp(chordmode{2,ct},'maj') && root2bass(cr, 'maj/3') == nb
            bassgram(j) = nb;
            treblegram(j) = tname2tnum('maj/3', chordmode);
        end
        if strcmp(chordmode{2,ct},'maj') && root2bass(cr, 'maj/5') == nb
            bassgram(j) = nb;
            treblegram(j) = tname2tnum('maj/5', chordmode);
        end
        % subcase2 -> cr == cb && cb = nb, such as (Bmaj <- Emaj/5, G#min <- Emaj/3), use
        % uppergram to judge
        if strcmp(chordmode{2,ct},'min') && cb == nb
            s1 = sumug(pitchTranspose(cb,3)) + sumug(pitchTranspose(cb,8)); % maj/3 upper
            s2 = sumug(pitchTranspose(cb,3)) + sumug(pitchTranspose(cb,7)); % min upper
            if s1 > s2
                rootgram(j) = bass2root(cb,'maj/3');
                treblegram(j) = tname2tnum('maj/3', chordmode);
            end
        end
        if strcmp(chordmode{2,ct},'maj') && cb == nb
            s1 = sumug(pitchTranspose(cb,5)) + sumug(pitchTranspose(cb,9)); % maj/5 upper
            s2 = sumug(pitchTranspose(cb,4)) + sumug(pitchTranspose(cb,7)); % maj upper
            if s1 > s2
                rootgram(j) = bass2root(cb,'maj/5');
                treblegram(j) = tname2tnum('maj/5', chordmode);
            end
        end
    end
end