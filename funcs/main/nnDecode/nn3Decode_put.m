function nn3Decode_put(tline, rawbasegram, rawuppergram)

X = [rawbasegram;rawuppergram]';

tline = strrep(tline(1:end-4),'/','-');
savename = ['./data/x/', tline, '-ch', '-','songwise.mat'];

save(savename,'X');
