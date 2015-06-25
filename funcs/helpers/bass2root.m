% given the treble name, compute the root for the given bass
% note that $bass is a number, while $treble is a string
function root = bass2root(bass, treble)

transval = trebleTransval(treble);
transval = -transval;

root = pitchTranspose(bass, transval);