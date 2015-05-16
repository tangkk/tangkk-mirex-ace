% merge similar chords
% 1st pass: merge consecutive chords that share the same bass and same super type
% 2nd pass: merge consecutive chords if it follows 1->5 relationship
% 3rd pass: merge consecutive chords that share the same root and same treble type
function [rootgram, bassgram, treblegram, bdrys] =...
    mergeSimilarChords(rootgram, bassgram, treblegram, bdrys, chordmode)

nchords = size(rootgram,2);

% 1st pass: merge consecutive chords that share the same bass and same super type
% 2nd pass: merge consecutive chords if it follows 1->5 relationship

copybassgram = bassgram;
for i = 1:1:nchords - 1
    cb = bassgram(i);
    ct = treblegram(i);
    ctname = chordmode{2,ct};
    cst = superTypeMapping(ctname);
    % give special attention to the fifth
    cb5th = pitchTranspose(cb,7);
    
    nb = bassgram(i+1);
    nt = treblegram(i+1);
    ntname = chordmode{2,nt};
    nst = superTypeMapping(ntname);
    
    if cb == nb && cst ~= nst
        % always merge to the supertype 3
        if cst == 3 && nst ~= 3
            treblegram(i+1) = treblegram(i);
            rootgram(i+1) = rootgram(i);
        elseif cst ~= 3 && nst == 3
            treblegram(i) = treblegram(i+1);
            rootgram(i) = rootgram(i+1);
        else
            continue;
        end
    end
    
    if cb5th == nb && cst ~= nst
        % merge the 5 chord to the 1 chord
        treblegram(i+1) = treblegram(i);
        rootgram(i+1) = rootgram(i);
        copybassgram(i+1) = bassgram(i);
    end
end

bassgram = copybassgram;

% 2nd pass: merge consecutive chords that share the same root and same treble type
for i = 1:1:nchords - 1
    cr = rootgram(i);
    ct = treblegram(i);
    ctname = chordmode{2,ct};
    ctt = trebleTypeMapping(ctname);
    
    nr = rootgram(i+1);
    nt = treblegram(i+1);
    ntname = chordmode{2,nt};
    ntt = trebleTypeMapping(ntname);
    
    if cr == nr && ctt == ntt %FIXME: should I consider trebletype here?
        if isempty(strfind(ctname,'/'))
            treblegram(i+1) = treblegram(i);
            bassgram(i+1) = bassgram(i);
        elseif isempty(strfind(ntname,'/'))
            treblegram(i) = treblegram(i+1);
            bassgram(i) = bassgram(i+1);
        else
            continue;
        end
    end
end

[rootgram, bassgram, treblegram, bdrys] = combineSameChords(rootgram, bassgram, treblegram, bdrys);