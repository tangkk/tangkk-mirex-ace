% according to the toneProfileGen.m, if the tuning is correct,
% every bin corresponding to the note should be lying on bin notenum*3-1
% which means the true lighten bin should be bin 2, 5, 8, 11, ...
% we can tune the preliminary salience matrix according to this criteria
% the tuning is performed in a column-wise manner

function S =  globalTuning(S)

% S = normalizeGram(S,inf);

nslices = size(S,2);
ntones = size(S,1);
C = zeros(1,3);
cvec = [];
mvec = [];
for j = 1:nslices
    % c = sum(S,2);
    col = S(:,j);
    for k = 1:1:3
       C(k) = sum(col(k:3:end)); 
    end
    x = [0 1 2];
    y = [C(1) C(2) C(3)];
    p = polyfit(x,y,2); % quadratic fit
    pvals = polyval(p,0:0.01:2);
    [M,I] = max(pvals);
    if M ~= 0
        c = (I - 1) * 0.01 - 1;
        cvec = [cvec c];
        mvec = [mvec M];
    end
end

mvec = mvec ./ norm(mvec,1);
cen = cvec * mvec';
% disp(cen);

for j = 1:1:nslices
    cj = S(:,j);
    x = (0:1:ntones+1)';
    xi = x + cen;
    cj = interp1q(x,[0;cj;0],xi); % linear interpolate the thing with cen shift
    cj = cj(2:end-1);
    S(:,j) = cj;
end

