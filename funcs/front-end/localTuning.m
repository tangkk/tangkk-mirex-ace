% localTuning algorithm
% according to the toneProfileGen.m, if the tuning is correct,
% every bin corresponding to the note should be lying on bin notenum*3-1
% which means the true lighten bin should be bin 2, 5, 8, 11, ...
% we can tune the preliminary salience matrix according to this criteria
% the tuning is performed in a column-wise manner
function S =  localTuning(S)

len = size(S,2);
ntones = size(S,1);
C = zeros(1,3);

for j = 1:1:len
    c = S(:,j);
%     for k = 1:1:3
%         C(k) = sum(c(k:3:end));
%     end
%     [~,idx] = max(C);
% %     disp(C); 
%     
%     % coarse adjustment (shift left or right)
%     if idx == 1 % tuning < 440 Hz, move upward
%         c(2:end) = c(1:end-1);
%         c(1) = 0;
%     elseif idx == 3 % tuning > 440 Hz, move downward
%         c(1:end - 1) = c(2:end);
%         c(end) = 0;
%     end
    
    % fine tune (compute the peak, and bin 1 and 3 same amplitude)
    for k = 1:1:3
        C(k) = sum(c(k:3:end)); 
    end
%     disp(C);
    x = [0 1 2];
    y = [C(1) C(2) C(3)];
    p = polyfit(x,y,2); % quadratic fit
    pvals = polyval(p,0:0.1:2);
    [~,I] = max(pvals);
    cen = (I - 1) * 0.1 - 1; % cen from -1 to 1
    
    x = (0:1:ntones+1)';
    xi = x + cen;
    c = interp1q(x,[0;c;0],xi); % linear interpolate the thing with cen shift
    c = c(2:end-1);
%     for k = 1:1:3
%         C(k) = sum(c(k:3:end));
%     end
%     disp(C);
    S(:,j) = c;
end