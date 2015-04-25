function scale = calNoteScale(nfSeq)

scale = cell(7,size(nfSeq,2));

for i = 1:1:size(scale,2)
    nfi = nfSeq(:,i);
    [~, ridx] = sort(nfi);
    scalei = cell(7,1);
    for j = length(ridx) : -1 : length(ridx) - 6
        scalei{length(ridx) - j + 1} = num2note(ridx(j));
    end
    scale(:,i) = scalei;
end