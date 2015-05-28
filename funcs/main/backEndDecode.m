function [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode,...
    basegram, uppergram, bdrys, grainsize, enCast2MajMin, nslices, df, enPlot)

bnet = dbnSetup(chordmode);

% [rootgram, bassgram, treblegram] = simChordMatching(basegram, uppergram, chordmode);
[rootgram, bassgram, treblegram] = dbnInference(bnet, chordmode, basegram, uppergram);

[rootgram, bassgram, treblegram, uppergram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, uppergram, bdrys, grainsize, enCast2MajMin, chordmode);

bassnotenames = {'N','C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
if df && enPlot
myLinePlot(1:length(rootgram), rootgram, 'chord progression order', 'semitone',...
    length(rootgram), 12, 'o', 'rootgram', 0:12, bassnotenames);
myLinePlot(1:length(bassgram), bassgram, 'chord progression order', 'semitone',...
    length(bassgram), 12, 'o', 'bassgram', 0:12, bassnotenames);
myLinePlot(1:length(bdrys), bdrys, 'chord progression order', 'slice',...
    length(bdrys), nslices, 'o', 'boundaries');
end

if df && enPlot
    visualizeChordProgression(rootgram, bassgram, treblegram, bdrys, chordmode);
end
