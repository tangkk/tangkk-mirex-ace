% parse a chord back to bass + treble, where bass is a 'int', and treble
% is a 'string'
function [bass,treble] = parseBassTreble(ch)

if strcmp(ch,'N')
    bass = 0;
    treble = 'N';
else
    tokens = strsplit(ch,':');
    root = note2num(tokens{1});
    treble = tokens{2};
    bass = root2bass(root,treble);
end