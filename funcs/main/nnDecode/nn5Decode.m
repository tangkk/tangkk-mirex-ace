function [rootgram, bassgram, treblegram, bdrys] = nn5Decode(chordmode, model, beparam, dbn2param, ns, bdrys)

display('chord decoding...');

win = 6; % assuming 6seg, every seg has 2 slices
if ~isempty(strfind(model,'-inv-'))
    nchords = 277;
elseif ~isempty(strfind(model,'-noinv-'))
    nchords = 61;
elseif ~isempty(strfind(model,'-no7'))
    nchords = 73;
end

bnet4 = dbnSetup4(dbn2param, nchords);
chordogram = computeNSChordogram(ns, chordmode, model, win);
[chordogram, ~] = normalizeGram(chordogram, inf);
[rootgram, bassgram, treblegram] = dbnInference4(bnet4, chordmode, chordogram, nchords);

if beparam.enChordGestalt
[rootgram, bassgram, treblegram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, bdrys, beparam, chordmode);
end

display('chord progression done...');
