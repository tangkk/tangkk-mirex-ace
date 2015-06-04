% cast the chords to mirex 2015 standard vocabulary
% which contains, maj, min, maj7, min7, 7 and there inversions
% note that the root and bass is unchanged, only treble is affected
function treblegram = castChords(nfSeq,...
    bassgram, treblegram, chordmode)

nchords = size(bassgram,2);

% the table for MajMinSevenths chord
castTarget = {'maj','min','maj7','min7','7'};
castlen = length(castTarget);
castIdx = zeros(1,castlen);
for i = 1:1:castlen
    ti = castTarget{i};
    for j = 1:1:size(chordmode,2)
        tc = chordmode{2,j};
        if strcmp(ti,tc)
            castIdx(i) = j;
        end
    end
end

for i = 1:1:nchords
    bass = bassgram(i);
    treble = treblegram(i);
    
    ch = strcat(num2note(bass),':',chordmode{2,treble});
    nch = cast2MajMin(ch, nfSeq);
    
    if ~strcmp(ch, nch)
        tokens = strsplit(nch,':');
        tname = tokens{2};

        for j = 1:1:castlen
            if strcmp(castTarget{j}, tname)
                treble = castIdx(j);
                break;
            end
        end
        treblegram(i) = treble;
    end
    
end