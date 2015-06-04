function [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, dbnparam,...
    basegram, uppergram, bdrys, grainsize, enCast2MajMin, nslices, df, enPlot)

bnet = dbnSetup(chordmode, dbnparam);

% [rootgram, bassgram, treblegram] = simChordMatching(basegram, uppergram, chordmode);
[rootgram, bassgram, treblegram] = dbnInference(bnet, chordmode, basegram, uppergram);

% [rootgram, bassgram, treblegram, uppergram, bdrys] = ...
%     chordLevelGestalt(rootgram, bassgram, treblegram, uppergram, bdrys,...
%     grainsize, enCast2MajMin, chordmode);

bassnotenames = {'N','C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
nchords = length(rootgram);
if df && enPlot
myLinePlot(1:nchords, rootgram, 'chord progression order', 'semitone',...
    nchords, 12, 'o', 'rootgram', 0:12, bassnotenames);
myLinePlot(1:nchords, bassgram, 'chord progression order', 'semitone',...
    nchords, 12, 'o', 'bassgram', 0:12, bassnotenames);
myLinePlot(1:nchords+1, bdrys, 'chord progression order', 'slice',...
    nchords, nslices, 'o', 'boundaries');
end

if df && enPlot
    visualizeChordProgression(rootgram, bassgram, treblegram, bdrys, chordmode);
end
