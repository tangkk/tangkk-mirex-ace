function [rootgram, bassgram, treblegram, bdrys] = nnbackEndDecode(chordmode, model, beparam, dbn2param, rawbasegram, rawuppergram, bdrys)

display('chord decoding...');

if beparam.enTheanoNN == 1
    [rootgram, bassgram, treblegram] = theanoNNTypeOnePredict(rawbasegram, rawuppergram, chordmode, dbn2param, model);
elseif beparam.enTheanoNN == 3
    [rootgram, bassgram, treblegram] = theanoNNTypeThreePredict(rawbasegram, rawuppergram, bdrys, chordmode, model);
end

if beparam.enChordGestalt
[rootgram, bassgram, treblegram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, bdrys, beparam, chordmode);
end

display('chord progression done...');
