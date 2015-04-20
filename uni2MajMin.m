% FIXME: currently limited to sus2, sus4, maj6, min6
function ch = uni2MajMin(ch,nf)

if ~isempty(strfind(ch,'sus2')) || ~isempty(strfind(ch,'sus4'))
    tokens = strsplit(ch,':');
    root = note2num(tokens{1});
    
    % min: 3,7, maj: 4,7
    minP = pitchTranspose(root,3);
    majP = pitchTranspose(root,4);
    if nf(minP) > nf(majP)
        ch = [num2note(root) ':' 'min'];
    elseif nf(majP) > nf(minP)
        ch = [num2note(root) ':' 'maj'];
    else
        ch = [num2note(root) ':' '5'];
    end
elseif ~isempty(strfind(ch,'maj6'))
    ch = ch(1:end-1);
elseif ~isempty(strfind(ch,'min6'))
    ch = ch(1:end-1);
else
    ch = ch;
end