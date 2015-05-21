function [So, Sb, Shc, basegram, uppergram] = midEndDecode(S, wgmax, df, enCom, enRed, enPlot)

nslices = size(S, 2);
ntones = size(S, 1);
kk = (1:nslices);
p = 1:ntones;

if enCom
st = 0.0;
S = compensateLongSalience(S,wgmax,st,0,0);
if df && enPlot
myImagePlot(S, kk, p, 'slice', 'semitone', 'positive gestalt note salience matrix');
end
end

if enRed
st = 0.0;
S = reduceShortSalience(S,wgmax,st,0,0);
if df && enPlot
myImagePlot(S, kk, p, 'slice', 'semitone', 'negative gestalt note salience matrix');
end
end

display('midend...');

Sg = S; % interface to mid-end

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
myLinePlot(1:length(Sb), Sb, 'slice', 'semitone',nslices, ntones, '*', 'bassline');
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

% compute basegram and uppergram (based on harmonic change matrix)
basegram = computeBasegram(Shv);
uppergram = computeUppergram(Shv);
bassnotenames = {'N','C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
treblenotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
kh = 1:nchords;
ph = 1:12;
if df && enPlot
myLinePlot(kh, basegram(1,:), 'chord progression order', 'semitone',...
    nchords, 12, 'o', 'basegram', 0:12, bassnotenames);
myImagePlot(uppergram, kh, ph, 'chord progression order', 'semitone',...
    'uppergram', ph,treblenotenames);
end
