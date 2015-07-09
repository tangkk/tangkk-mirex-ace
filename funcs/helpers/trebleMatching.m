function [tname, treble] = trebleMatching(bass,upper,chordmode)

if sum(upper) >= 10 % this is the 'no-chord' condition (too many light bins)
    tname = 'N';
    treble = 0;
    return;
end

% match by final score in each chord modes, if ties, selects the one
% with lower index
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
    tname = 'N'; % this is the 'no-chord' condition (no light bins)
    treble = 0;
end
