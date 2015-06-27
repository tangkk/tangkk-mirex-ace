function out = note2num(in)

if strcmp(in,'C') || strcmp(in,'B#')
    out = 1;
elseif strcmp(in,'C#') || strcmp(in,'Db')
    out = 2;
elseif strcmp(in,'D')
    out = 3;
elseif strcmp(in,'D#') || strcmp(in,'Eb')
    out = 4;
elseif strcmp(in,'E') || strcmp(in,'Fb')
    out = 5;
elseif strcmp(in,'F') || strcmp(in, 'E#')
    out = 6;
elseif strcmp(in,'F#') || strcmp(in,'Gb')
    out = 7;
elseif strcmp(in,'G')
    out = 8;
elseif strcmp(in,'G#') || strcmp(in,'Ab')
    out = 9;
elseif strcmp(in,'A')
    out = 10;
elseif strcmp(in,'A#') || strcmp(in,'Bb')
    out = 11;
elseif strcmp(in,'B') || strcmp(in,'Cb')
    out = 12;
else
    out = 0;
end