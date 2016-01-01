% delete inversion chords from chordnames

function nchordnames = deleteinversions(chordnames)

nchordnames = [];
for i = 1:length(chordnames)
    if ~(~cellfun(@isempty,(strfind(chordnames(i),'/'))))
        nchordnames = [nchordnames; chordnames(i)];
    end
end