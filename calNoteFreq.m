% calculate the frequencies of every note in well temperament
% FIXME: shall we compute a static nf or dynamic nf?
function nf = calNoteFreq(bassgram, treblegram, chordmode, hwin)

nf = zeros(12,length(bassgram)); % compute a dynamic note frequencies
for i = 1:1:length(bassgram)
    range = max(i-hwin,1):1:min(i+hwin,length(bassgram));
    nfi = zeros(12,1);
    for j = range(1):1:range(end)
        bass = bassgram(j);
        cmidx = treblegram(j);
        if cmidx == 0
            continue;
        end
        treble = chordmode{1,cmidx};
        treble = [0 treble];
        for k = 1:1:length(treble)
            p = pitchTranspose(bass, treble(k));
            nfi(p) = nfi(p) + 1;
        end
    end
    nf(:,i) = nfi;
end