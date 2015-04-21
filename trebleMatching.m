function [treble, ctidx] = trebleMatching(bass,upper,template)

if sum(upper) >= 8 % this is the 'no-chord' condition (too many light bins)
    treble = '1';
    ctidx = 0;
    return;
end

% match by final score in each chord modes, if ties, selects the one
% with lower index
chordmode = template;
nchordtype = length(chordmode);
treblescore = zeros(1,nchordtype);
for i = 1:1:nchordtype
    uppermode = zeros(12,1);
    uppermode(pitchTranspose(bass, chordmode{1,i})) = chordmode{3,i};
    treblescore(i) = upper'*uppermode;
end
[maxscore,ctidx] = max(treblescore);
if maxscore > 0
    treble = chordmode{2,ctidx};
else
    treble = '1'; % this is the 'no-chord' condition (no light bins)
    ctidx = 0;
end
