% chord template matching, pick the one with the highest score
% chordogram: 1st row: bass num; 2nd row: root num; 3rd row: treble idx
function chordogram = computeChordogram(basegram, uppergram, chordtemplate)

nchords = size(basegram,2);
chordogram = zeros(3,nchords);
for j = 1:1:nchords
    bass = basegram(1,j); % now we don't need the bass strength information
    upper = uppergram(:,j);
    [tname, treble] = trebleMatching(bass, upper, chordtemplate);
    root = bass2root(bass, tname);
    chordogram(1,j) = root;
    chordogram(2,j) = bass;
    chordogram(3,j) = treble;
end