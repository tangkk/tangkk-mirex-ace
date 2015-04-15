function root = bass2root(bass, treble)

transval = trebleTransval(treble);
transval = -transval;

root = pitchTranspose(bass, transval);