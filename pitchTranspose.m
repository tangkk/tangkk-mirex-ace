function out = pitchTranspose(in, transval)

out = mod(in+transval-1,12)+1;