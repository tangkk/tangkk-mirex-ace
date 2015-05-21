% compute note frequencies and tonic (dynamically)

function [scaleSeq, tonicSeq] = tonicDecode(bassgram, treblegram, bdrys, chordmode, df, enPlot)
hwin = 5;
nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
scaleSeq = calNoteScale(nfSeq);
tonicSeq = calTonic(scaleSeq);
if df && enPlot
    visualizeTonicProgression(tonicSeq, bdrys);
end