function [rootgram, bassgram, treblegram, bdrys] = nnbackEndDecode(chordmode, model, beparam, dbn2param, rawbasegram, rawuppergram, bdrys)

display('chord decoding...');

win = 6; % assuming 6seg, every seg has 2 slices
if ~isempty(strfind(model,'-inv-'))
    nchords = 277;
elseif ~isempty(strfind(model,'-noinv-'))
    nchords = 61;
end
bnet4 = dbnSetup4(dbn2param, nchords);
chordogram = computeNNChordogram(rawbasegram, rawuppergram, chordmode, model, win);
[chordogram, ~] = normalizeGram(chordogram, inf);
[rootgram, bassgram, treblegram] = dbnInference4(bnet4, chordmode, chordogram, nchords);

if beparam.enChordGestalt
[rootgram, bassgram, treblegram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, bdrys, beparam, chordmode);
end

display('chord progression done...');
