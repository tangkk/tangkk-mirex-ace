% parse a chord back to bass + treble, where bass is a 'int', and treble
% is a 'string'
function [bass,treble] = parseBassTreble(ch)

if strcmp(ch,'N')
    bass = 0;
    treble = 'N';
elseif ~isempty(strfind(ch,':'))
    tokens = strsplit(ch,':');
    root = note2num(tokens{1});
    treble = tokens{2};
    bass = root2bass(root,treble);
elseif ~isempty(strfind(ch,'/'))
    % this is for major triad inversions (also without ':')
    tokens = strsplit(ch,'/');
    root = note2num(tokens{1});
    treble = ['maj/' tokens{2}];
    bass = root2bass(root,treble);
else
    % this is for major triads (with no ':')
    root = note2num(ch);
    treble = 'maj';
    bass = root;
end