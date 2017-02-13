function nn4Decode_put(tline,ns)

X = ns';

tline = strrep(tline(1:end-4),'/','-');
savename = ['./data/x/', tline, '-ns', '-','songwise.mat'];

save(savename,'X');