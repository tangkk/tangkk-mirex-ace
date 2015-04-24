% tuning algorithm
% according to the toneProfileGen.m, if the tuning is correct,
% every bin corresponding to the note should be lying on bin notenum*3-1
% which means the true lighten bin should be bin 2, 5, 8, 11, ...
% we can tune the preliminary salience matrix according to this criteria
% the tuning is performed in a column-wise manner
function S =  tuning(S, numsemitones)

len = size(S,2);
C = zeros(1,numsemitones);
center = (numsemitones + 1) / 2;

for i = 1:1:len
    c = S(:,i);
    for k = 1:1:numsemitones
        C(k) = sum(c(k:numsemitones:end));
    end
    [~,idx] = max(C);
    disp(C);
    
    if idx < center % tuning < 440 Hz, move upward
        c(center:end) = c(idx:end-(center-idx));
        c(1:idx) = 0;
    elseif idx > center % tuning > 440 Hz, move downward
        c(center:end - (idx-center)) = c(idx:end);
        c(1:idx) = 0;
        c(end - (idx-center) + 1:end) = 0;
    end
    S(:,i) = c;
    for k = 1:1:numsemitones
        C(k) = sum(c(k:numsemitones:end));
    end
    disp(C);
end