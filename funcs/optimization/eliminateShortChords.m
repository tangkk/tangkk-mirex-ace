% eliminate chords with very short duration, update other grams
% the eliminated chords should be replaced by the previous chords
function [rootgram, bassgram, treblegram, bdrys] = ...
    eliminateShortChords(rootgram, bassgram, treblegram, bdrys, grain)

% chord beat duration calculation
nchords = size(rootgram,2);
difbdrys = bdrys(2:end) - bdrys(1:end-1);
chordbeats = round(difbdrys ./ (median(difbdrys) / 4));

% eliminate candidates selection:
% 1. findout short chord indexes
shortchords = chordbeats;
shortchords(shortchords <= grain) = 0;
shortchordidx = find(shortchords == 0);

% 2. findout non chord indexes that's with a relatively short duration
nonchords = find(treblegram == 1);
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
rootgram(elimiateidxes) = [];
bassgram(elimiateidxes) = [];
treblegram(elimiateidxes) = [];
bdrys(elimiateidxes) = []; % the bdrys indicates the start of a chord
% deleting at start of a chord makes it follows the previous chord

