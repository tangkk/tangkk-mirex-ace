% scale is a 7-element cell

function tonic = calTonic(scaleSeq)

seed = [0 2 4 5 7 9 11]; % C maj scale

tm = zeros(12,12);
for i = 1:1:12
    for j = 1:1:length(seed)
        p = pitchTranspose(seed(j),i);
        tm(i,p) = 1;
    end
end

tonic = cell(1,size(scaleSeq,2));

for i = 1:1:length(tonic)
    scale = scaleSeq(:,i);
    target = zeros(1,12);
    for j = 1:1:length(scale)
        target(note2num(scale{j})) = 1;
    end

    score = zeros(1,12);
    for j = 1:1:12
        score(j) = sum(~xor(tm(j,:),target));
    end

    [~,I] = max(score);
    tonici = num2note(I);
    tonic{i} = tonici;
end
