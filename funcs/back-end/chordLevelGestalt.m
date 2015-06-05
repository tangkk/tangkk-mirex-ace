% the chord-level gestalt process
function [rootgram, bassgram, treblegram, uppergram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, uppergram,...
    bdrys, grainsize, enCast2MajMin, chordmode)

% compute note frequencies and tonic (dynamically), and do treble casting
if enCast2MajMin
hwin = 5; nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
treblegram = castChords(nfSeq, bassgram, treblegram, chordmode);
end

[rootgram, bassgram, treblegram, uppergram, bdrys] = combineSameChords(rootgram,...
    bassgram, treblegram, uppergram, bdrys);

% [rootgram, bassgram, treblegram, uppergram, bdrys] = eliminateShortChords(rootgram,...
%     bassgram, treblegram, uppergram, bdrys, grainsize);

% [rootgram, bassgram, treblegram, uppergram, bdrys] = mergeSimilarChords(rootgram,...
%     bassgram, treblegram, uppergram, bdrys, nfSeq, chordmode);