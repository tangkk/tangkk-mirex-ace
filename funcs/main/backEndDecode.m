function [rootgram, bassgram, treblegram, bdrys] = backEndDecode(bdrys, chordmode,...
    basegram, uppergram, grainsize, enCast2MajMin, nslices, df, enPlot)

chordogram = computeChordogram(basegram, uppergram, chordmode);

% the chord-level gestalt process
rootgram = chordogram(1,:); bassgram = chordogram(2,:); treblegram = chordogram(3,:);

[rootgram, bassgram, treblegram, uppergram,bdrys] = combineSameChords(rootgram,...
    bassgram, treblegram, uppergram, bdrys);

[rootgram, bassgram, treblegram, uppergram, bdrys] = eliminateShortChords(rootgram,...
    bassgram, treblegram, uppergram, bdrys, grainsize);

% compute note frequencies and tonic (dynamically), and do treble casting
if enCast2MajMin
hwin = 5; nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
treblegram = castChords(nfSeq, bassgram, treblegram, chordmode);
end

[rootgram, bassgram, treblegram, uppergram, bdrys] = mergeSimilarChords(rootgram,...
    bassgram, treblegram, uppergram, bdrys, nfSeq, chordmode);

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
