% try chord recognition tree method (or chord dictionary method)
% run the bass through this tree, if hit, then that's the chord rooted
% on the bass
% if miss, then run every other pitch through this tree, pick a hit with
% root closest to the bass to form a slash chord

% walk the tree using basegram and uppergram
% chordogram: 1st row: bass num; 2st row: treble type;
% 3st row: treble root; 4th row: chord entry index
function chordogram = computeChordogram(basegram, uppergram, chordtemplate)

nchords = length(basegram);
chordogram = cell(4,nchords);
for j = 1:1:nchords
    bass = basegram(1,j); % now we don't need the bass strength information
    upper = uppergram(:,j);
    [treble, ctidx] = trebleMatching(bass, upper, chordtemplate);
    if strcmp(treble,'1')
        chordogram{1,j} = bass;
        chordogram{2,j} = 'maj'; % FIXME: noew we use 'maj' to substitute '1'
        chordogram{3,j} = num2note(bass);
        chordogram{4,j} = 0;
    else
        chordogram{1,j} = bass;
        chordogram{2,j} = treble;
        root = bass2root(bass, treble);
        chordogram{3,j} = num2note(root);
        chordogram{4,j} = ctidx;
    end
end