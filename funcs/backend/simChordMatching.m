% chord template matching, pick the one with the highest score
% note that it works with a 1-D basegram
function [rootgram, bassgram, treblegram] = simChordMatching(basegram, uppergram, chordmode)

nslices = size(basegram,2);
rootgram = zeros(1,nslices);
bassgram = zeros(1,nslices);
treblegram = zeros(1,nslices);
for j = 1:1:nslices
    bass = basegram(1,j); % the basegram(2,j) is strength information
    upper = uppergram(:,j);
    [tname, treble] = trebleMatching(bass, upper, chordmode);
    root = bass2root(bass, tname);
    rootgram(j) = root;
    bassgram(j) = bass;
    treblegram(j) = treble;
end