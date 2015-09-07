% transpose a chord using chord numbers
function nchnum = chTranspose(ochnum, transval)

nchnum = '0:0';

if ~strcmp(ochnum,'0:0') % skip the N chord
    strtoks = strsplit(ochnum,':');
    root = strtoks{1};
    treble = strtoks{2};
    
    % transpose it
    root = num2str(pitchTranspose(str2double(root),transval));
    
    nchnum = strcat(root,':',treble);
end