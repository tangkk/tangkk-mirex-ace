% cast the ground truth label to seventhsbass label
% cast non-7th to 7th chords
% delete brackets

function nch = castGtLabel(och, noinv)

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

% cast all 6th chords to majmin
if ~isempty(strfind(nch,'6'))
    pos = strfind(nch,'6');
    nch = [nch(1:pos-1) nch(pos+1:end)];
end

% if no support of inversions, delete the inversion part
if noinv && ~isempty(strfind(nch,'/'))
    pos = strfind(nch,'/');
    nch = nch(1:pos-1);
end
