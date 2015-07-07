% chord template matching, pick the one with the highest score
function [rootgram, bassgram, treblegram] = simChordMatching(basegram, uppergram, chordmode)

nchords = size(basegram,2);
rootgram = zeros(1,nchords);
bassgram = zeros(1,nchords);
treblegram = zeros(1,nchords);
for j = 1:1:nchords
    bass = basegram(1,j); % now we don't need the bass strength information
    upper = uppergram(:,j);
    [tname, treble] = trebleMatching(bass, upper, chordmode);
    root = bass2root(bass, tname);
    rootgram(j) = root;
    bassgram(j) = bass;
    treblegram(j) = treble;
end