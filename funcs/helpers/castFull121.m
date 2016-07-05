% cast the ground truth label to maj, min, maj/3, maj/5, maj6, maj7, min7, 7, dim and aug for each of 12 keys plus no-chord.

function nch = castFull121(och)

nch = och;

% stripe off the content in between the brackets (including the brackets)
if ~isempty(strfind(och,'('))
    pos1 = strfind(och,'(');
    pos2 = strfind(och,')');
    nch = [och(1:pos1-1) och(pos2+1:end)];
end

% cast all 9th, 11th, 13th chords to 7ths
if ~isempty(strfind(nch,'9'))
    pos = strfind(nch,'9');
    nch = [nch(1:pos-1) '7' nch(pos+1:end)];
end
if ~isempty(strfind(nch,'11'))
    pos = strfind(nch,'11');
    nch = [nch(1:pos-1) '7' nch(pos+2:end)];
end
if ~isempty(strfind(nch,'13'))
    pos = strfind(nch,'13');
    nch = [nch(1:pos-1) '7' nch(pos+2:end)];
end

% cast all min6 chords to min, keep the maj6
if ~isempty(strfind(nch,'min6'))
    pos = strfind(nch,'6');
    nch = [nch(1:pos-1) nch(pos+1:end)];
end

% delete all min inversions and third inversions
if ~isempty(strfind(nch,'min/')) || ~isempty(strfind(nch,'min7/')) || ~isempty(strfind(nch,'/7')) || ~isempty(strfind(nch,'/b7'))
    pos = strfind(nch,'/');
    nch = nch(1:pos-1);
end

if ~isempty(strfind(nch,'7/5')) || ~isempty(strfind(nch,'7/3'))
    pos = strfind(nch,'7');
    nch = [nch(1:pos-1) nch(pos+1:end)];
end
