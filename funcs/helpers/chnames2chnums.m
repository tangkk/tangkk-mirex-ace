function chordnums = chnames2chnums(chordnames, chordmode)

chordnums = cell(length(chordnames),1);
for i = 1:length(chordnames)
    ch = chordnames{i};
    strtoks = strsplit(ch,':');
    root = strtoks{1};
    treble = strtoks{2};
    cr = note2num(root);
    ct = tname2tnum(treble, chordmode);
    chordnums{i} = strcat(num2str(cr),':',num2str(ct));
end