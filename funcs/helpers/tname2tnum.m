% given chordmode, compute treble num from treble names

function tnum = tname2tnum(tname, chordmode)

tnum = 0;
nct = size(chordmode,2);
for j = 1:nct
    tstr = chordmode{2,j};
    if strcmp(tname, tstr)
        tnum = j;
        break;
    end
end
