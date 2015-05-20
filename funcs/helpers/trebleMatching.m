function [tname, treble] = trebleMatching(bass,upper,template)

if sum(upper) >= 10 % this is the 'no-chord' condition (too many light bins)
    tname = '1';
    treble = 1;
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
[maxscore,treble] = max(treblescore);
if maxscore > 0
    tname = chordmode{2,treble};
else
    tname = '1'; % this is the 'no-chord' condition (no light bins)
    treble = 1;
end
