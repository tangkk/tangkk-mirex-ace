% correct the bassgram based on the first 1/8 of the harmonic regions of
% the basegram, and update rootgram and treblegram accordingly.
% The dominant bass of the 1/8 of
% the harmonic stable region will be the chord bass of the whole harmonic
% region

function [rootgram, bassgram, treblegram] = bassCorrect(rootgram,...
    bassgram, treblegram, basegram, bdrys, chordmode)

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
    sumbg = sum(bgbdb,2);
    % cal new bass
    [~,bass] = max(sumbg);
    % bass correct: only correct those wrong chord inversions cases
    % case1: the recognized result is an inversion but actually it is not
        % subcase1 -> cr != cb && cr = nb, such as (Emaj/5 <- Emaj)
        % subcase2 -> cr != cb && cb = nb, such as (Emaj/5 <- Bmaj), but no base to
        % judge this case
    % case2: the recognized result is not an inversion but actually it is
        % subcase1 -> cr == cb && cr != nb, such as (Emaj <- Emaj/5)
        % subcase2 -> cr == cb && cb = nb, such as (Bmaj <- Emaj/5), but no base to
        % judge this case
    % no other case is considered for now
    % the process assumes the root is correct
    cb = bassgram(j);
    cr = rootgram(j);
    ct = treblegram(j);
    nb = bass;
    if cb ~= 0 && nb ~= cb && cr ~= cb
        % /3 case, indicating a wrong /3 recognition, bass should be the
        % same as root
        if strcmp(chordmode{2,ct},'maj/3') && cr == nb
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj', chordmode);
        end
        % /5 case, indicating a wrong /5 recognition, bass should be the
        % same as root
        if strcmp(chordmode{2,ct},'maj/5') && cr == nb
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj', chordmode);
        end
    end
    
    if cb ~= 0 && nb ~= cb && cr == cb
        % non-inversion case, indicating a wrong maj recognition
        if strcmp(chordmode{2,ct},'maj') && root2bass(cr, 'maj/3') == nb
            bassgram(j) = nb;
            treblegram(j) = tname2tnum('maj/3', chordmode);
        end
        % non-inversion case, indicating a wrong maj recognition
        if strcmp(chordmode{2,ct},'maj') && root2bass(cr, 'maj/5') == nb
            bassgram(j) = nb;
            treblegram(j) = tname2tnum('maj/5', chordmode);
        end

    end
end