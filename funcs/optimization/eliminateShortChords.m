% this is another gestalize process that eliminate non-chords or chords with very short
% duration into the chords nearby with reasonable duration
function [chordogram, bassgram, treblegram, boundaries] = eliminateShortChords(chordogram, bassgram, treblegram, boundaries, grain)

% chord beat duration calculation
nchords = length(chordogram);
difbdrys = boundaries(2:end) - boundaries(1:end-1);
chordbeats = round(difbdrys ./ (median(difbdrys) / 4));

% eliminate candidates selection:
% 1. findout short chord indexes
shortchords = chordbeats;
shortchords(shortchords <= grain) = 0;
shortchordidx = find(shortchords == 0);

% 2. findout non chord indexes that's with a relatively short duration
nonchords = find(treblegram == 0);
nonchordidx = [];
for i = 1:1:length(nonchords)
    nci = nonchords(i);
    if chordbeats(nci) < 2
        nonchordidx = [nonchordidx nci];
    end
end

elimiateidxes = [shortchordidx nonchordidx];
if ~isempty(elimiateidxes)
    if elimiateidxes(end) == nchords
        % the last chord cannot be eliminate
        elimiateidxes(end) = [];
    end
end
if ~isempty(elimiateidxes)
    if elimiateidxes(1) == 1
        % the first chord cannot be eliminate
        elimiateidxes(1) = [];
    end
end

% eliminate process
chordogram(elimiateidxes) = [];
bassgram(elimiateidxes) = [];
treblegram(elimiateidxes) = [];
boundaries(elimiateidxes) = [];

