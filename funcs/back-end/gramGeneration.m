function [outchordogram, outbassgram, outtreblegram, outboundaries] = gramGeneration(inchordogram, inboundaries)

outchordogram = cell(1,size(inchordogram,2));
outbassgram = zeros(1,size(inchordogram,2));
outtreblegram = zeros(1,size(inchordogram,2));
outboundaries = zeros(1,size(inboundaries,2));
for i = 1:1:size(inchordogram,2)
    curchord = strcat(inchordogram{3,i},':',inchordogram{2,i});
    curbass = inchordogram{1,i};
    curtreble = inchordogram{4,i};
    outchordogram{i} = curchord;
    outbassgram(i) = curbass;
    outtreblegram(i) = curtreble;
    outboundaries(i) = inboundaries(i);
end
outboundaries(end) = inboundaries(end);