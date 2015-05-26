function [fs, hopsize, nslices, endtime, S] = frontEndDecode(audiopath, stereotomono, df, enPlot)

[x, fs] = myInput(audiopath, stereotomono);

% transform time domain into frequency domain
wl = 4096;
hopsize = 512;
X = mySpectrogram(x, wl, hopsize);
sizeX = size(X);
nslices = sizeX(2);
endtime = (1/fs)*length(x);
tk = (1/fs)*(1:length(x));
kk = (1:nslices);
ff = fs/2*linspace(0,1,wl/2);
if df && enPlot
myImagePlot(X, kk, ff, 'slice', 'Hz', 'spectrogram');
end

% note dictionary
fmin = 27.5; % MIDI note 21, Piano key number 1
fmax = 1661; % MIDI note 92, Piano key number numnotes
fratio = 2^(1/(12*3));
numnotes = 72;
numtones = numnotes*3; % numsemitones = 3
[Ms,Mc] = toneProfileGen(wl, numtones, 3, fmin, fmax, fratio, fs);
if df && enPlot
myImagePlot(Ms, 1:wl/2, 1:numtones, 'time', '1/3 semitone', 'simple tone profile');
myImagePlot(Mc, 1:wl/2, 1:numtones, 'time', '1/3 semitone', 'complex tone profile');
end

% calculate note salience matrix of the stft spectrogram (cosine
% similarity) (note that this is an additive approach, as contrast to
% the nnls approach which is an deductive approach)
Ss = Ms*X;
Sc = Mc*X;
sizeM = size(Ms);
ps = 1:sizeM(1);

% tuning algorithm, assuming numsemitones = 3
Sst = globalTuning(Ss);
Sct = globalTuning(Sc);
if df && enPlot
myImagePlot(Ss, kk, ps, 'slice', '1/3 semitone', 'simple tone salience matrix');
myImagePlot(Sst, kk, ps, 'slice', '1/3 semitone', 'tuned simple tone salience matrix');
myImagePlot(Sc, kk, ps, 'slice', '1/3 semitone', 'complex tone salience matrix');
myImagePlot(Sct, kk, ps, 'slice', '1/3 semitone', 'tuned complex tone salience matrix');
end

% noise reduction process
nt = 0.1;
Ssn = noteSalienceNoiseReduce(Sst, nt);
Scn = noteSalienceNoiseReduce(Sct, nt);
if df && enPlot
myImagePlot(Ssn, kk, ps, 'slice', '1/3 semitone', 'noised reduced simple tone salience matrix');
myImagePlot(Scn, kk, ps, 'slice', '1/3 semitone', 'noised reduced complex tone salience matrix');
end

% computer note salience matrix by combining 1/3 semitones into semitones
Sss = zeros(numnotes,nslices);
Scc = zeros(numnotes,nslices);
for i = 1:1:3
    Sss = Sss + Ssn(i:3:end,:);
    Scc = Scc + Scn(i:3:end,:);
end
S = Sss.*Scc;
sizeS = size(S);
ntones = sizeS(1);
S = normalizeGram(S);
p = 1:ntones;
if df && enPlot
myImagePlot(Sss, kk, p, 'slice', '1/3 semitone', 'Ss note salience matrix');
myImagePlot(Scc, kk, p, 'slice', '1/3 semitone', 'Sc note salience matrix');
myImagePlot(S, kk, p, 'slice', 'semitone', 'note salience matrix');
end
