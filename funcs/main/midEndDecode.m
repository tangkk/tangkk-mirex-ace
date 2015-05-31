function [So, Sb, bdrys, basegram, uppergram] = midEndDecode(S, mdparam, df, enPlot)

nslices = size(S, 2);
ntones = size(S, 1);
kk = (1:nslices);
p = 1:ntones;

if mdparam.enGesComp
st = 0.0;
S = compensateLongSalience(S,mdparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(S, kk, p, 'slice', 'semitone', 'positive gestalt note salience matrix');
end
end

if mdparam.enGesRed
st = 0.0;
S = reduceShortSalience(S,mdparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(S, kk, p, 'slice', 'semitone', 'negative gestalt note salience matrix');
end
end

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
Sb = bassLineFilter(Sg, bt, mdparam.wgmax, cb);
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

if mdparam.useOriginalSalience
    Ssegin = S;
else
    Ssegin = Sg;
end

% segment the piece according to the median value of dif boundaries or
% wgmax
if mdparam.useWindowSegment
    mdifbdry = mdparam.wgmax;
else
    mdifbdry = round(median(Shc(2:end) - Shc(1:end-1)));
end

Ssegout = zeros(size(Ssegin,1), ceil(size(Ssegin,2)/mdifbdry));
for j = 1:size(Ssegout,2)
    Ssegout(:,j) = mean(Ssegin(:,(j-1) * mdifbdry + 1 : min(j*mdifbdry,size(Ssegin,2))),2);
end
if df && enPlot
myImagePlot(Ssegout, 1:size(Ssegout,2), p, 'segmentation',...
    'semitone', 'note salience segmentation matrix');
end

if mod(Shc(end),mdifbdry) == 0
    bdrys = 1:mdifbdry:Shc(end);
else
    bdrys = [1:mdifbdry:Shc(end) Shc(end)];
end

% compute basegram and uppergram (based on harmonic change matrix)
if mdparam.useBassSegment
    basegram = computeBasegram(Shv); uppergram = computeUppergram(Shv);
else
    basegram = computeBasegram(Ssegout); uppergram = computeUppergram(Ssegout);
end
bassnotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
treblenotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
kh = 1:nchords;
ph = 1:12;
if df && enPlot
myImagePlot(basegram, kh, ph, 'chord progression order', 'semitone',...
    'basegram', ph, bassnotenames);
myImagePlot(uppergram, kh, ph, 'chord progression order', 'semitone',...
    'uppergram', ph, treblenotenames);
end
