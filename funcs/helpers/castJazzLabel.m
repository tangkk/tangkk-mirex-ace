% cast the jazz label to match chordmode-jazz.mat vocabulary

function nch = castJazzLabel(och)

nch = och;

% stripe off the content in between the brackets (including the brackets)
if ~isempty(strfind(och,'('))
    pos1 = strfind(och,'(');
    pos2 = strfind(och,')');
    nch = [och(1:pos1-1) och(pos2+1:end)];
end

% if no support of inversions, delete the inversion part
if ~isempty(strfind(nch,'/'))
    pos = strfind(nch,'/');
    nch = nch(1:pos-1);
end