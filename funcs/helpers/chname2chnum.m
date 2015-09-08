function chordnum = chname2chnum(chordname, chordmode)

chordnum = '0:0';

% FIXME: should include N chord in the future
if ~strcmp(chordname,'N') % skip the N chord
    if isempty(strfind(chordname,':')) % add ':maj' to maj chords
        root = chordname;
        treble = 'maj';
    else
        strtoks = strsplit(chordname,':');
        root = strtoks{1};
        treble = strtoks{2};
    end
    cr = note2num(root);
    ct = tname2tnum(treble, chordmode);
    chordnum = strcat(num2str(cr),':',num2str(ct));
end