function scale = calNoteScale(notefrequencies)

[~, ridx] = sort(notefrequencies);
scale = cell(1,7);
for i = length(ridx) : -1 : length(ridx) - 6
    scale{length(ridx) - i + 1} = num2note(ridx(i));
end