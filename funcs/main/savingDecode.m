function [bdrys] = savingDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys)

display('chord decoding...');
if beparam.useSIM1 % apply simple chord matching, works with a 1-D basegram
[rootgram, bassgram, treblegram] = simChordMatching(basegram, uppergram, chordmode);

elseif beparam.useDBN1 % apply dbn 1, works with 12-D basegram
bnet = dbnSetup(chordmode, dbnparam);
[rootgram, bassgram, treblegram] = dbnInference(bnet, chordmode, basegram, uppergram);

elseif beparam.useDBN2 % apply dbn 2, works with 12-D basegram
bnet2 = dbnSetup2(chordmode, dbn2param);
chordogram = computeChordogram(basegram, uppergram, chordmode, dbn2param);
[chordogram, ~] = normalizeGram(chordogram, beparam.normalization);
[rootgram, bassgram, treblegram] = dbnInference2(bnet2, chordmode, chordogram);
end

if beparam.enChordGestalt
[rootgram, bassgram, treblegram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, bdrys, beparam, chordmode);
end

