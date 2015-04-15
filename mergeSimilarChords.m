% this is a process to merge chords with same bass and similar type into
% one chord. Assume there are two chords to be merged, the mergee is the one with
% less notes, while the merger is the one with more notes; if both are with
% the same number of notes, the second one is to be merged to the first one
% there are totally three super chord types: 1. those with 3 (major
% type), 2. those with 3b (minor type), 3. those without 3 or 3b (universal
% type). Chords within same type can be merged. Type 1 and Type 2 can be
% merged into type 3 or merge from type 3, but type 1 and type 2 cannot
% be merged into each other.
function [chordogram, bassgram, treblegram, boundaries] = mergeSimilarChords(chordogram, bassgram, treblegram, boundaries, chordmode)

nchords = length(chordogram);
for i = 1:1:nchords - 1
    cb = bassgram(i);
    ct = treblegram(i);
    nb = bassgram(i+1);
    nt = treblegram(i+1);
    % first condition, current bass = next bass
    if cb == nb && ct ~= 0 && nt ~= 0
        cttn = chordmode{4,ct};
        nttn = chordmode{4,nt};
        ctt = cttn(1);
        ctn = cttn(2);
        ntt = nttn(1);
        ntn = nttn(2);
        % second condition, type equal or there's at least one type 3
        if ctt == ntt || ctt == 3 || ntt == 3
            % third condition, number of notes priority
            if ctn > ntn
                treblegram(i+1) = treblegram(i);
                chordogram(i+1) = chordogram(i);
            end
            if ctn < ntn
                treblegram(i) = treblegram(i+1);
                chordogram(i) = chordogram(i+1);
            end
            if ctn == ntn
                treblegram(i+1) = treblegram(i);
                chordogram(i+1) = chordogram(i);
            end
            continue;
        end
    end
end

[chordogram, bassgram, treblegram, boundaries] = combineSameChords(chordogram, bassgram, treblegram, boundaries);
