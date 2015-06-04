function Shc = harmonicSegmentation(Sg, wgmax, df, enPlot)

ntones = size(Sg,1);
nslices = size(Sg,2);

% onset filter (roughly detect the note onsets)
ot = 0.0;
wo = 10;
So = noteOnsetFilter(Sg, ot, wo);
if df && enPlot
myImagePlot(So, kk, p, 'slice', 'semitone', 'note onset matrix');
end

% bassline filter (roughly set the dynamic bass bounds)
bt = 0.0;
cb = 1;
Sb = bassLineFilter(Sg, bt, wgmax, cb);
if df && enPlot
myLinePlot(1:length(Sb), Sb, 'slice', 'semitone', nslices, ntones, '*', 'bassline');
end

% harmonic change filter (detect harmonic change boundaries)ht = 0.1;
ht = 0.1;
bc = 6;
[Sh, Shv, Shc, nchords] = harmonicChangeFilter(Sg, Sb, So, ht, bc);
if df && enPlot
myImagePlot(Sh, kk, p, 'slice', 'semitone', 'harmonic bounded salience matrix');
myImagePlot(Shv, kk(1:nchords), p, 'chord progression order',...
    'semitone', 'harmonic change matrix');
myLinePlot(1:length(Shc), Shc, 'chord progression order', 'slice',...
    nchords, nslices, 'o', 'haromonic change moments');
end