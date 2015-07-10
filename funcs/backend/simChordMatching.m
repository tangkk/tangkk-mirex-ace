% chord template matching, pick the one with the highest score
% note that it works with a 1-D basegram
function [rootgram, bassgram, treblegram] = simChordMatching(basegram, uppergram, chordmode)

nslices = size(basegram,2);
rootgram = zeros(1,nslices);
bassgram = zeros(1,nslices);
treblegram = zeros(1,nslices);
for j = 1:1:nslices
    bass = basegram(1,j); % this is for 1-D basegram
    upper = uppergram(:,j);
    [tname, treble] = trebleMatching(bass, upper, chordmode);
    if treble ~= 0
        root = bass2root(bass, tname);
        rootgram(j) = root;
        bassgram(j) = bass;
        treblegram(j) = treble;
    else
        rootgram(j) = 0;
        bassgram(j) = 0;
        treblegram(j) = 0;
    end
end