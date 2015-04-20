% FIXME: currently limited to sus2 and sus4
function ch = sus2MajMin(ch,nf)

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
else
    ch = ch;
end