% btVersion3 + inversion correct subcase 2

function [rootgram, bassgram, treblegram] = bassTrebleCorrect4(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode)

nslices = size(rootgram,2);

% bass decision boundary = 1/8 of the harmonic stable region, which is a
% reasonable value intuitively. It means the dominant bass of the 1/8 of
% the harmonic stable region will be the chord bass of the whole harmonic
% region
bdb = 1/8;

tmaj = chordmode{1, tname2tnum('maj', chordmode)};
tmin = chordmode{1, tname2tnum('min', chordmode)};
tmajon3 = chordmode{1, tname2tnum('maj/3', chordmode)};
tmajon5 = chordmode{1, tname2tnum('maj/5', chordmode)};
tminonb3 = chordmode{1, tname2tnum('min/b3', chordmode)};
tminon5 = chordmode{1, tname2tnum('min/5', chordmode)};
tmaj7 = chordmode{1, tname2tnum('maj7', chordmode)};
tmin7 = chordmode{1, tname2tnum('min7', chordmode)};
t7 = chordmode{1, tname2tnum('7', chordmode)};
tmaj7on3 = chordmode{1, tname2tnum('maj7/3', chordmode)};
tmaj7on5 = chordmode{1, tname2tnum('maj7/5', chordmode)};
tmaj7on7 = chordmode{1, tname2tnum('maj7/7', chordmode)};
tmin7onb3 = chordmode{1, tname2tnum('min7/b3', chordmode)};
tmin7on5 = chordmode{1, tname2tnum('min7/5', chordmode)};
tmin7onb7 = chordmode{1, tname2tnum('min7/b7', chordmode)};
t7on3 = chordmode{1, tname2tnum('7/3', chordmode)};
t7on5 = chordmode{1, tname2tnum('7/5', chordmode)};
t7onb7 = chordmode{1, tname2tnum('7/b7', chordmode)};

wmaj = chordmode{3, tname2tnum('maj', chordmode)};
wmin = chordmode{3, tname2tnum('min', chordmode)};
wmaj7 = chordmode{3, tname2tnum('maj7', chordmode)};
wmin7 = chordmode{3, tname2tnum('min7', chordmode)};
w7 = chordmode{3, tname2tnum('7', chordmode)};
wmajon3 = chordmode{3, tname2tnum('maj/3', chordmode)};
wmajon5 = chordmode{3, tname2tnum('maj/5', chordmode)};
wminonb3 = chordmode{3, tname2tnum('min/b3', chordmode)};
wminon5 = chordmode{3, tname2tnum('min/5', chordmode)};
wmaj7on3 = chordmode{3, tname2tnum('maj7/3', chordmode)};
wmaj7on5 = chordmode{3, tname2tnum('maj7/5', chordmode)};
wmaj7on7 = chordmode{3, tname2tnum('maj7/7', chordmode)};
wmin7onb3 = chordmode{3, tname2tnum('min7/b3', chordmode)};
wmin7on5 = chordmode{3, tname2tnum('min7/5', chordmode)};
wmin7onb7 = chordmode{3, tname2tnum('min7/b7', chordmode)};
w7on3 = chordmode{3, tname2tnum('7/3', chordmode)};
w7on5 = chordmode{3, tname2tnum('7/5', chordmode)};
w7onb7 = chordmode{3, tname2tnum('7/b7', chordmode)};

for j = 1:nslices
    bd1 = bdrys(j);
    bd2 = bdrys(j+1);
    % hsr = bd1:bd2; % harmonic stable region
    hsrbdb = bd1:min(bd1 + floor((bd2 - bd1 + 1)*bdb), bd2);
    bgbdb = basegram(:,hsrbdb);
    ugbdb = uppergram(:,hsrbdb);
    sumbg = sum(bgbdb,2);
    sumug = sum(ugbdb,2);
    % cal new bass
    [~,bass] = max(sumbg);
    % inversion correct: only correct those wrong chord inversions cases
    % case1: the recognized result is an inversion but actually it is not
        % subcase1 -> cr != cb && cr == nb, such as (Emaj/5 -> Emaj, Emaj/3 -> Emaj), use
        % basegram to judge
        % subcase2 -> cr != cb && cb == nb, such as (Emaj/5 -> Bmaj, Emaj/3 -> G#min), use
        % uppergram to judge
    % case2: the recognized result is not an inversion but actually it is
        % subcase1 -> cr == cb && cr != nb, such as (Emaj -> Emaj/5, Emaj -> Emaj/3), use
        % basegram to judge
        % subcase2 -> cr == cb && cb == nb, such as (Bmaj -> Emaj/5, G#min -> Emaj/3), use
        % uppergram to judge
    % no other case is considered for now
    % the process assumes the root is correct
    
    % sevenths correct
    % case3: the recognized result is majmin but actually it's sevenths
        % subcases: maj -> maj7 or 7, min -> min7
    % case4: the recognized result is seventh but actually it's majmin
        % subcases: maj7 -> maj, 7 -> maj, min7 -> min
    % the process assumes the majmin is correct
    
    cb = bassgram(j);
    cr = rootgram(j);
    ct = treblegram(j);
    nb = bass;
    
    % score should be computed in terms of bass
    smaj = wmaj*sumug(pitchTranspose(cb,tmaj));
    smin = wmin*sumug(pitchTranspose(cb,tmin));
    smaj7 = wmaj7*sumug(pitchTranspose(cb,tmaj7));
    smin7 = wmin7*sumug(pitchTranspose(cb,tmin7));
    s7 = w7*sumug(pitchTranspose(cb,t7));
    smajon3 = wmajon3*sumug(pitchTranspose(cb,tmajon3));
    smajon5 = wmajon5*sumug(pitchTranspose(cb,tmajon5));
    sminonb3 = wminonb3*sumug(pitchTranspose(cb,tminonb3));
    sminon5 = wminon5*sumug(pitchTranspose(cb,tminon5));
    smaj7on3 = wmaj7on3*sumug(pitchTranspose(cb,tmaj7on3));
    smaj7on5 = wmaj7on5*sumug(pitchTranspose(cb,tmaj7on5));
    smaj7on7 = wmaj7on7*sumug(pitchTranspose(cb,tmaj7on7));
    smin7onb3 = wmin7onb3*sumug(pitchTranspose(cb,tmin7onb3));
    smin7on5 = wmin7on5*sumug(pitchTranspose(cb,tmin7on5));
    smin7onb7 = wmin7onb7*sumug(pitchTranspose(cb,tmin7onb7));
    s7on3 = w7on3*sumug(pitchTranspose(cb,t7on3));
    s7on5 = w7on5*sumug(pitchTranspose(cb,t7on5));
    s7onb7 = w7onb7*sumug(pitchTranspose(cb,t7onb7));
    
    % seventh correct -------------------------------------------------
    if cb ~= 0 && cr == cb
        if strcmp(chordmode{2,ct},'maj')
            if smaj7 > smaj || s7 > smaj
                if smaj7 > s7
                    treblegram(j) = tname2tnum('maj7', chordmode); 
                else
                    treblegram(j) = tname2tnum('7', chordmode);
                end
            end
        end
        
        if strcmp(chordmode{2,ct},'min')
            if smin7 > smin
                treblegram(j) = tname2tnum('min7', chordmode); 
            end
        end
        
        if strcmp(chordmode{2,ct},'maj7')
            if smaj > smaj7
                treblegram(j) = tname2tnum('maj', chordmode); 
            end
        end
        
        if strcmp(chordmode{2,ct},'7')
            if smaj > s7
                treblegram(j) = tname2tnum('maj', chordmode); 
            end
        end
        
        if strcmp(chordmode{2,ct},'min7')
            if smin > smin7
                treblegram(j) = tname2tnum('min', chordmode); 
            end
        end
    end
    
    % inversion correct -----------------------------------------------
    % **************************case 1***********************************
    
    % subcase1 -> cr != cb && cr == nb, such as (Emaj/5 -> Emaj, Emaj/3 -> Emaj), use
    % basegram to judge
    if cb ~= 0 && cr ~= cb && cr == nb
        % triad case - majminbass
        if strcmp(chordmode{2,ct},'maj/3')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj', chordmode);
        end
        if strcmp(chordmode{2,ct},'maj/5')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj', chordmode);
        end
        
        if strcmp(chordmode{2,ct},'min/b3')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('min', chordmode);
        end
        if strcmp(chordmode{2,ct},'min/5')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('min', chordmode);
        end
        
        % tetrad case - sevenths bass
        if strcmp(chordmode{2,ct},'maj7/3')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj7', chordmode);
        end
        if strcmp(chordmode{2,ct},'maj7/5')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj7', chordmode);
        end
        if strcmp(chordmode{2,ct},'maj7/7')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('maj7', chordmode);
        end
        
        if strcmp(chordmode{2,ct},'7/3')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('7', chordmode);
        end
        if strcmp(chordmode{2,ct},'7/5')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('7', chordmode);
        end
        if strcmp(chordmode{2,ct},'7/b7')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('7', chordmode);
        end
        
        if strcmp(chordmode{2,ct},'min7/b3')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('min7', chordmode);
        end
        if strcmp(chordmode{2,ct},'min7/5')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('min7', chordmode);
        end
        if strcmp(chordmode{2,ct},'min7/b7')
            bassgram(j) = cr;
            treblegram(j) = tname2tnum('min7', chordmode);
        end
    end
    
    % subcase2 -> cr != cb && cb == nb, such as (Emaj/5 -> Bmaj, Emaj/3 -> G#min), use
    % uppergram to judge (easily confused chords)
    if cb ~= 0 && cr ~= cb && cb == nb
        if strcmp(chordmode{2,ct},'maj/3') && cb == nb % easily confused with min or min/5 (with same bass)
            if smin > smajon3 || sminon5 > smajon3
                if smin > sminon5
                    rootgram(j) = cb;
                    treblegram(j) = tname2tnum('min', chordmode);
                else
                    rootgram(j) = pitchTranspose(cr, -3); % try num2note(pitchTranspose(note2num('x'),-3)) to check
                    treblegram(j) = tname2tnum('min/5', chordmode);
                end
            end
        end
        if strcmp(chordmode{2,ct},'maj7/3') && cb == nb % easily confused with min or min/5 (with same bass)
            if smin > smaj7on3 || sminon5 > smaj7on3
                if smin > sminon5
                    rootgram(j) = cb;
                    treblegram(j) = tname2tnum('min', chordmode);
                else
                    rootgram(j) = pitchTranspose(cr, -3); % try num2note(pitchTranspose(note2num('x'),-3)) to check
                    treblegram(j) = tname2tnum('min/5', chordmode);
                end
            end
        end
        if strcmp(chordmode{2,ct},'maj/5') && cb == nb % easily confused with maj, or min/b3 (with same bass)
            if smaj > smajon5 || sminonb3 > smajon5
                if smaj > sminonb3
                    rootgram(j) = cb;
                    treblegram(j) = tname2tnum('maj', chordmode);
                else
                    rootgram(j) = pitchTranspose(cr, 4);
                    treblegram(j) = tname2tnum('min/b3', chordmode);
                end
            end
        end
        if strcmp(chordmode{2,ct},'maj7/5') && cb == nb % easily confused with maj, or min/b3 (with same bass)
            if smaj > smaj7on5 || sminonb3 > smaj7on5
                if smaj > sminonb3
                    rootgram(j) = cb;
                    treblegram(j) = tname2tnum('maj', chordmode);
                else
                    rootgram(j) = pitchTranspose(cr, 4);
                    treblegram(j) = tname2tnum('min/b3', chordmode);
                end
            end
        end
    end
    
%     % **************************case 2***********************************
%     
%     % subcase1 -> cr == cb && cr != nb, such as (Emaj -> Emaj/5, Emaj -> Emaj/3), use
%     % basegram to judge
%     if cb ~= 0 && cr == cb && cr ~= nb
%         if strcmp(chordmode{2,ct},'maj') && root2bass(cr, 'maj/3') == nb
%             bassgram(j) = nb;
%             treblegram(j) = tname2tnum('maj/3', chordmode);
%         end
%         if strcmp(chordmode{2,ct},'maj') && root2bass(cr, 'maj/5') == nb
%             bassgram(j) = nb;
%             treblegram(j) = tname2tnum('maj/5', chordmode);
%         end
%     end
%     
%     % subcase2 -> cr == cb && cb == nb, such as (Bmaj -> Emaj/5, G#min ->
%     Emaj/3), use 
%     % uppergram to judge
%     if cb ~= 0 && cr == cb && cb == nb
%         if strcmp(chordmode{2,ct},'min')
%             s1 = sumug(pitchTranspose(cb,3)) + sumug(pitchTranspose(cb,8)); % maj/3 upper
%             s2 = sumug(pitchTranspose(cb,3)) + sumug(pitchTranspose(cb,7)); % min upper
%             if s1 > s2
%                 rootgram(j) = bass2root(cb,'maj/3');
%                 treblegram(j) = tname2tnum('maj/3', chordmode);
%             end
%         end
%         if strcmp(chordmode{2,ct},'maj')
%             s1 = sumug(pitchTranspose(cb,5)) + sumug(pitchTranspose(cb,9)); % maj/5 upper
%             s2 = sumug(pitchTranspose(cb,4)) + sumug(pitchTranspose(cb,7)); % maj upper
%             if s1 > s2
%                 rootgram(j) = bass2root(cb,'maj/5');
%                 treblegram(j) = tname2tnum('maj/5', chordmode);
%             end
%         end
%     end
end