% generate a (3*numtone, numtone) matrix
% this is a note profile in log-frequency domain

function E = nnlsNoteProfile(s, nnotes, ntones)

% EE = zeros(ntones, ntones); % ntones * ntones dict
E = zeros(ntones, nnotes); % ntones dict
% Ee = zeros(nnotes, nnotes); % nnotes dict
for i = 1:nnotes
    pr = zeros(ntones,1);
%     pre = zeros(nnotes,1);
    % all the way to the fourth overtone
    note0 = i; % fundamental
    note1 = note0 + 12; % first overtone (octave)
    note2 = note1 + 7; % second overtone (octave + fifth)
    note3 = note2 + 5; % third overtone (two octaves)
    % note4 = note3 + 4; % fourth overtone (two octaves + third)
    
    % transform into 1/3 semitone scale, locate note in center bins
    tone0 = 3*note0 - 1;
    tone1 = 3*note1 - 1;
    tone2 = 3*note2 - 1;
    tone3 = 3*note3 - 1;
    
    if tone0 <= ntones
        pr(tone0) = s^0;
%         pre(note0) = s^0;
    end
    if tone1 <= ntones
        pr(tone1) = s^1;
%         pre(note1) = s^1;
    end
    if tone2 <= ntones
        pr(tone2) = s^2;
%         pre(note2) = s^2;
    end
    if tone3 <= ntones
        pr(tone3) = s^3;
%         pre(note3) = s^3;
    end
    
    pr = pr ./ norm(pr, 1);
%     pre = pre ./ norm(pre, 1);
    
    E(:,i) = pr;
%     Ee(:,i) = pre;
%     EE(:,3*i-2) = [pr(2:end);0];
%     EE(:,3*i-1) = pr;
%     EE(:,3*i) = [0;pr(1:end-1)];
end