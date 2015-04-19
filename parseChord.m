% parse a chord back to root + quality + bass, where bass and root be
% 'int', and quality is a 'string'
function [root, quality, bass] = parseChord(ch)

if strcmp(ch,'N')
    root = 0;
    bass = 0;
    quality = 'N';
elseif ~isempty(strfind(ch,':'))
    tokens = strsplit(ch,':');
    root = note2num(tokens{1});
    tmp = strsplit(tokens{2},'/');
    quality = tmp{1};
    if length(tmp) > 1
        bass = root2bass(root,tmp{2});
    else
        bass = root;
    end
elseif ~isempty(strfind(ch,'/'))
    % this is for major triad inversions (also without ':')
    tokens = strsplit(ch,'/');
    root = note2num(tokens{1});
    quality = 'maj';
    bass = root2bass(root,tokens{2});
else
    % this is for major triads (with no ':')
    root = note2num(ch);
    quality = 'maj';
    bass = root;
end