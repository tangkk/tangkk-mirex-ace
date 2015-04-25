function bass = root2bass(root, treble)

transval = trebleTransval(treble);

bass = pitchTranspose(root, transval);