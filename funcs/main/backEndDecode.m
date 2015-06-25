function [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys, nslices, df, enPlot)

if beparam.useDBN1
    bnet = dbnSetup(chordmode, dbnparam);
    % [rootgram, bassgram, treblegram] = simChordMatching(basegram, uppergram, chordmode);
    [rootgram, bassgram, treblegram] = dbnInference(bnet, chordmode, basegram, uppergram);
elseif beparam.useDBN2
    bnet2 = dbnSetup2(chordmode, dbn2param);
    chordogram = computeChordogram(basegram, uppergram, chordmode, dbn2param);
    if df && enPlot
    myImagePlot(chordogram, 1:size(chordogram,2), 1:size(chordogram,1),...
        'chord progression order', 'chord', 'chordogram');
    end
    [rootgram, bassgram, treblegram] = dbnInference2(bnet2, chordmode, chordogram);
end

[rootgram, bassgram, treblegram, uppergram, bdrys] = ...
    chordLevelGestalt(rootgram, bassgram, treblegram, uppergram, bdrys,...
    beparam.grainsize, beparam.enCast2MajMin, chordmode);

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
