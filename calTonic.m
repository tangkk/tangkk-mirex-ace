% scale is a 7-element cell

function tonic = calTonic(scale)

seed = [0 2 4 5 7 9 11]; % C maj scale

tm = zeros(12,12);
for i = 1:1:12
    for j = 1:1:length(seed)
        p = pitchTranspose(seed(j),i);
        tm(i,p) = 1;
    end
end

target = zeros(1,12);
for i = 1:1:length(scale)
    target(note2num(scale{i})) = 1;
end

score = zeros(1,12);
for i = 1:1:12
    score(i) = sum(~xor(tm(i,:),target));
end

[~,I] = max(score);
tonic = num2note(I);
