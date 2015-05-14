% combine the same chords
% if two consecutive estimated chords are the same, skip the latter one
% and skip all other grams at that position.
function [outrootgram, outbassgram, outtreblegram, outbdrys] =...
    combineSameChords(inrootgram, inbassgram, intreblegram, inbdrys)


outrootgram = zeros(1,size(inbassgram,2));
outbassgram = zeros(1,size(inbassgram,2));
outtreblegram = zeros(1,size(intreblegram,2));
outbdrys = zeros(1,size(inbdrys,2));

outrootgram(1) = inrootgram(1);
outbassgram(1) = inbassgram(1);
outtreblegram(1) = intreblegram(1);
outbdrys(1) = inbdrys(1);

pr = inrootgram(1);
pb = inbassgram(1);
pt = intreblegram(1);
outidx = 2;
nchords = size(inrootgram,2);
for i = 2:1:nchords
    cr = inrootgram(i);
    cb = inbassgram(i);
    ct = intreblegram(i);
    if pr == cr && pb == cb && pt == ct
        continue;
    else
        outrootgram(outidx) = cr;
        outbassgram(outidx) = cb;
        outtreblegram(outidx) = ct;
        outbdrys(outidx) = inbdrys(i);
        outidx = outidx + 1;
    end
    pr = cr; pb = cb; pt = ct;
end

outrootgram = outrootgram(1:outidx-1);
outbassgram = outbassgram(1:outidx-1);
outtreblegram = outtreblegram(1:outidx-1);
outbdrys(outidx) = inbdrys(end);
outbdrys = outbdrys(1:outidx);