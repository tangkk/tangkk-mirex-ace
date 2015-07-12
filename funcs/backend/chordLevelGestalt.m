% the chord-level gestalt process
function [rootgram, bassgram, treblegram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, basegram, uppergram,...
    bdrys, beparam, chordmode)

% compute note frequencies and tonic (dynamically), and do treble casting
if beparam.enCast2MajMin
hwin = 5; nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
treblegram = castChords(nfSeq, rootgram, treblegram, chordmode);
end

if beparam.enCombSameChords
[rootgram, bassgram, treblegram, bdrys] = combineSameChords(rootgram,...
    bassgram, treblegram, bdrys);
end

if beparam.enEliminShortChords
[rootgram, bassgram, treblegram, bdrys] = eliminateShortChords(rootgram,...
    bassgram, treblegram, bdrys, beparam.grainsize);
end

if beparam.enBassTrebleCorrect
[rootgram, bassgram, treblegram] = bassTrebleCorrect(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode);
end

if beparam.enMergeSimilarChords
hwin = 5; nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
[rootgram, bassgram, treblegram, uppergram, bdrys] = mergeSimilarChords(rootgram,...
    bassgram, treblegram, uppergram, bdrys, nfSeq, chordmode);
end