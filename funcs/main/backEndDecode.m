function [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, rawbasegram, rawuppergram, bdrys, df, enPlot)

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


if beparam.enBassTrebleCorrect
if beparam.enTheanoNN % if using TheanoNN, use raw basegram and uppergram
display('work with theano NN model...');
[rootgram, bassgram, treblegram] = feval(['bassTrebleCorrect',num2str(beparam.btcVersion)],rootgram,...
    bassgram, treblegram, rawbasegram, rawuppergram, bdrys, chordmode);
else % otherwise use normalized basegram and uppergram
display('work with simple model...');
[rootgram, bassgram, treblegram] = feval(['bassTrebleCorrect',num2str(beparam.btcVersion)],rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode);
end
end

bassnotenames = {'N','C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
nslices = length(rootgram);
if beparam.useDBN2 && df && enPlot
myImagePlot(chordogram, 1:size(chordogram,2), 1:size(chordogram,1),...
'chord progression order', 'chord', 'chordogram');
end
if df && enPlot
myLinePlot(1:nslices, rootgram, 'chord progression order', 'semitone',...
    nslices, 12, 'o', 'rootgram', 0:12, bassnotenames);
myLinePlot(1:nslices, bassgram, 'chord progression order', 'semitone',...
    nslices, 12, 'o', 'bassgram', 0:12, bassnotenames);
myLinePlot(1:nslices+1, bdrys, 'chord progression order', 'slice',...
    nslices, bdrys(end), 'o', 'boundaries');
visualizeChordProgression(rootgram, bassgram, treblegram, bdrys, chordmode);
end

display('chord progression done...');
