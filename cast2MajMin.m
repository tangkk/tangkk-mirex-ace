% FIXME: currently limited chord vocabulary
function ch = cast2MajMin(ch,nf)

if ~isempty(strfind(ch,'sus2')) || ~isempty(strfind(ch,'sus4'))
    tokens = strsplit(ch,':');
    root = note2num(tokens{1});
    
    % min: 3,7, maj: 4,7
    minP = pitchTranspose(root,3);
    majP = pitchTranspose(root,4);
    if nf(minP) > nf(majP)
        ch = [num2note(root) ':' 'min'];
    else
        ch = [num2note(root) ':' 'maj'];
    end
elseif ~isempty(strfind(ch,'maj6')) || ~isempty(strfind(ch,'min6'))
    ch = ch(1:end-1);
elseif ~isempty(strfind(ch,'maj9')) || ~isempty(strfind(ch,'min9'))
    ch = ch(1:end-1);
elseif ~isempty(strfind(ch,'maj11')) || ~isempty(strfind(ch,'min11'))
    ch = ch(1:end-2);
elseif ~isempty(strfind(ch,':9')) || ~isempty(strfind(ch,':11'))
    tokens = strsplit(ch,':');
    ch = [tokens{1} ':' '7'];
elseif ~isempty(strfind(ch,'madd9')) || ~isempty(strfind(ch,'madd11'))
    tokens = strsplit(ch,':');
    ch = [tokens{1} ':' 'min'];
elseif ~isempty(strfind(ch,'add9')) || ~isempty(strfind(ch,'add11'))
    tokens = strsplit(ch,':');
    ch = [tokens{1} ':' 'maj'];
elseif ~isempty(strfind(ch,'aug'))
    tokens = strsplit(ch,':');
    ch = [tokens{1} ':' 'maj'];
elseif ~isempty(strfind(ch,'dim'))
    tokens = strsplit(ch,':');
    ch = [tokens{1} ':' 'min'];
elseif ~isempty(strfind(ch,'dim7')) || ~isempty(strfind(ch,'hdim7')) || ~isempty(strfind(ch,'minmaj7'))
    tokens = strsplit(ch,':');
    ch = [tokens{1} ':' 'min7'];
else
    ch = ch;
end