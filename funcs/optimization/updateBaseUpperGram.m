% part of the feedback route, update the basegram and uppergram
function [newbasegram, newuppergram] = updateBaseUpperGram(chordboundaries, S, So, ut, nt)

nchords = length(chordboundaries) - 1;

newbasegram = zeros(1,nchords);
for i = 1:1:nchords
    wb = chordboundaries(i):chordboundaries(i+1);
    Sw = S(:,wb);
    Swo = So(:,wb);
    base = findBase(Sw, Swo);
    newbasegram(i) = pitchTranspose(base,9);
end

newuppergram = zeros(12,nchords);
for i = 1:1:nchords
    % update note salience matrix in terms of boundaries window
    wb = chordboundaries(i):chordboundaries(i+1);
    % the first criteria is the sum of strength larger than ut
    Sw = S(:,wb);
    sm1 = sum(Sw,2);
    sm1(sm1 <= ut) = 0;
    % the second criteria is the sum of number of light bins > nt*len(wb)
    Sw(Sw > 0) = 1;
    sm2 = sum(Sw,2);
    sm2(sm2 <= nt*length(wb)) = 0;
    sm2(sm2 > nt*length(wb)) = 1;
    sm = sm1.*sm2;
    upg = sum(reshape(sm,12,6),2);
    upg = [upg(4:end);upg(1:3)];
    newuppergram(:,i) = upg;
end

newuppergram = normalizeGram(newuppergram);