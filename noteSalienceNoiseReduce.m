function outNS = noteSalienceNoiseReduce(inNS, nt)

sizeNS = size(inNS);
outNS = zeros(sizeNS(1),sizeNS(2));
for j = 1:1:sizeNS(2)
    outNS(:,j) = inNS(:,j) / max(inNS(:,j));
    vs = inNS(:,j);
    [pkss,locss] = findpeaks(vs,'MinPeakHeight',nt,'MinPeakProminence',nt);
    vs = zeros(sizeNS(1),1);
    vs(locss) = pkss;
    outNS(:,j) = vs;
end