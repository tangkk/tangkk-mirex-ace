% combine the same chords
function [outchordogram, outbassgram, outtreblegram, outboundaries] = combineSameChords(inchordogram, inbassgram, intreblegram, inboundaries)

prevchord = inchordogram{1};
outchordogram = cell(1,size(inchordogram,2));
outbassgram = zeros(1,size(inbassgram,2));
outtreblegram = zeros(1,size(intreblegram,2));
outchordogram{1} = prevchord;
outbassgram(1) = inbassgram(1);
outtreblegram(1) = intreblegram(1);
outboundaries = zeros(1,size(inboundaries,2));
outboundaries(1) = inboundaries(1);
outidx = 2;
for i = 2:1:size(inchordogram,2)
    curchord = inchordogram{i};
    curbass = inbassgram(i);
    curtreble = intreblegram(i);
    if strcmp(curchord,prevchord)
        continue;
    else
        outchordogram{outidx} = curchord;
        outbassgram(outidx) = curbass;
        outtreblegram(outidx) = curtreble;
        outboundaries(outidx) = inboundaries(i);
        outidx = outidx + 1;
    end
    prevchord = curchord;
end
outchordogram = outchordogram(1:outidx-1);
outbassgram = outbassgram(1:outidx-1);
outtreblegram = outtreblegram(1:outidx-1);
outboundaries(outidx) = inboundaries(end);
outboundaries = outboundaries(1:outidx);