function [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys, nslices, df, enPlot)

if beparam.useSIM1 % apply simple chord matching, works with a 1-D basegram
[rootgram, bassgram, treblegram] = simChordMatching(basegram, uppergram, chordmode);
elseif beparam.useDBN1 % apply dbn 1, works with 12-D basegram
bnet = dbnSetup(chordmode, dbnparam);
[rootgram, bassgram, treblegram] = dbnInference(bnet, chordmode, basegram, uppergram);
elseif beparam.useDBN2 % apply dbn 2, works with 12-D basegram
bnet2 = dbnSetup2(chordmode, dbn2param);
chordogram = computeChordogram(basegram, uppergram, chordmode, dbn2param);
[rootgram, bassgram, treblegram] = dbnInference2(bnet2, chordmode, chordogram);
end

if beparam.enChordGestalt
[rootgram, bassgram, treblegram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, basegram, uppergram, bdrys,...
    beparam.grainsize, beparam.enCast2MajMin, beparam.enCombSameChords, beparam.enBassCorrect,...
    beparam.enEliminShortChords, chordmode);
end

display('chordogram done...');

bassnotenames = {'N','C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
nslices = length(rootgram);
if beparam.useDBN2
myImagePlot(chordogram, 1:size(chordogram,2), 1:size(chordogram,1),...
'chord progression order', 'chord', 'chordogram');
end
if df && enPlot
myLinePlot(1:nslices, rootgram, 'chord progression order', 'semitone',...
    nslices, 12, 'o', 'rootgram', 0:12, bassnotenames);
myLinePlot(1:nslices, bassgram, 'chord progression order', 'semitone',...
    nslices, 12, 'o', 'bassgram', 0:12, bassnotenames);
myLinePlot(1:nslices+1, bdrys, 'chord progression order', 'slice',...
    nslices, nslices, 'o', 'boundaries');
visualizeChordProgression(rootgram, bassgram, treblegram, bdrys, chordmode);
end
