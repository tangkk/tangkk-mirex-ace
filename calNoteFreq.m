% calculate the frequencies of every note in well temperament
% FIXME: shall we compute a static nf or dynamic nf?
function nf = calNoteFreq(bassgram, treblegram, chordmode)

nf = zeros(1,12);
for i = 1:1:length(bassgram)
    bass = bassgram(i);
    cmidx = treblegram(i);
    if cmidx == 0
        continue;
    end
    treble = chordmode{1,cmidx};
    treble = [0 treble];
    for j = 1:1:length(treble)
        p = pitchTranspose(bass, treble(j));
        nf(p) = nf(p) + 1;
    end
end