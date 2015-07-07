% the chord-level gestalt process
function [rootgram, bassgram, treblegram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, basegram, uppergram,...
    bdrys, grainsize, enCast2MajMin, enCombSameChords, enBassCorrect, enEliminShortChords, chordmode)

% compute note frequencies and tonic (dynamically), and do treble casting
if enCast2MajMin
hwin = 5; nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
treblegram = castChords(nfSeq, rootgram, treblegram, chordmode);
end

if enCombSameChords
[rootgram, bassgram, treblegram, bdrys] = combineSameChords(rootgram,...
    bassgram, treblegram, bdrys);
end

if enBassCorrect
[rootgram, bassgram, treblegram] = bassCorrect(rootgram,...
    bassgram, treblegram, basegram, bdrys, chordmode);
end

if enEliminShortChords
[rootgram, bassgram, treblegram, bdrys] = eliminateShortChords(rootgram,...
    bassgram, treblegram, bdrys, grainsize);
end

% [rootgram, bassgram, treblegram, uppergram, bdrys] = mergeSimilarChords(rootgram,...
%     bassgram, treblegram, uppergram, bdrys, nfSeq, chordmode);