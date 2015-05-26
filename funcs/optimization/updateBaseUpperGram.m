% update the basegram and uppergram based on the chord boundaries
function [basegram, uppergram] = updateBaseUpperGram(bassgram, bdrys, S, So, ut, nt)

nchords = length(bdrys) - 1;

% basegram = zeros(2,nchords);
% for i = 1:1:nchords
%     wb = bdrys(i):bdrys(i+1);
%     Sw = S(:,wb);
%     Swo = So(:,wb);
%     [base, bstg] = findBase(Sw, Swo);
%     basegram(1,i) = pitchTranspose(base,9);
%     basegram(2,i) = bstg;
% end
basegram = [bassgram; ones(1,nchords)*0.8];

uppergram = zeros(12,nchords);
for i = 1:1:nchords
    % update note salience matrix in terms of boundaries window
    wb = bdrys(i):bdrys(i+1);
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
    uppergram(:,i) = upg;
end

uppergram = normalizeGram(uppergram);