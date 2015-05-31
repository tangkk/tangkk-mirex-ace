function [fs, nslices, endtime, S] = frontEndDecode(audiopath, feparam, df, enPlot)

[x, fs] = myInput(audiopath, feparam.stereotomono);

% transform time domain into frequency domain
X = mySpectrogram(x, feparam.wl, feparam.hopsize);
sizeX = size(X);
nslices = sizeX(2);
endtime = (1/fs)*length(x);
tk = (1/fs)*(1:length(x));
kk = (1:nslices);
ff = fs/2*linspace(0,1,feparam.wl/2);
if df && enPlot
myImagePlot(X, kk, ff, 'slice', 'Hz', 'spectrogram');
end

% note dictionary
fmin = 27.5; % MIDI note 21, Piano key number 1
fmax = 1661; % MIDI note 92, Piano key number numnotes
fratio = 2^(1/(12*3));
numnotes = 72;
numtones = numnotes*3; % numsemitones = 3
[Ms,Mc] = toneProfileGen(feparam.overtoneS, feparam.wl, numtones, 3, fmin, fmax, fratio, fs);
[EE, E, Ee] = logFreqNoteProfile(feparam.overtoneS, numnotes);
if df && enPlot
myImagePlot(Ms, 1:feparam.wl/2, 1:numtones, 'fft bin', '1/3 semitone', 'simple tone profile');
myImagePlot(Mc, 1:feparam.wl/2, 1:numtones, 'fft bin', '1/3 semitone', 'complex tone profile');
myImagePlot(EE, 1:3*numnotes, 1:3*numnotes, '1/3 semitone', '1/3 semitone', 'log freq note profile');
myImagePlot(E, 1:numnotes, 1:3*numnotes, 'semitone', '1/3 semitone', 'log freq note profile');
myImagePlot(Ee, 1:numnotes, 1:numnotes, 'semitone', 'semitone', 'log freq note profile');
end

% calculate note salience matrix of the stft spectrogram (cosine
% similarity) (note that this is an additive approach, as contrast to
% the nnls approach which is an deductive approach)
Ss = Ms*X;
Sc = Mc*X;
sizeM = size(Ms);
ps = 1:sizeM(1);
if df && enPlot
myImagePlot(Ss, kk, ps, 'slice', '1/3 semitone', 'simple tone salience matrix');
% myImagePlot(Sc, kk, ps, 'slice', '1/3 semitone', 'complex tone salience matrix');
end

if feparam.tuningBefore
% tuning algorithm, assuming numsemitones = 3
if feparam.globalTuning
    Ss = globalTuning(Ss);
    Sc = globalTuning(Sc);
else
    Ss = localTuning(Ss);
    Sc = localTuning(Sc);
end
Ss = Ss ./ max(max(Ss)); % global normalize
Sc = Sc ./ max(max(Sc)); % global normalize
if df && enPlot
myImagePlot(Ss, kk, ps, 'slice', '1/3 semitone', 'tuned simple tone salience matrix');
% myImagePlot(Sc, kk, ps, 'slice', '1/3 semitone', 'tuned complex tone salience matrix');
end
end

% suppress percussive moments
if feparam.enPcsSuppress
Ss = pcsSuppress(Ss, (max(sum(Ss))+mean(sum(Ss)))/2);
if df && enPlot
myImagePlot(Ss, kk, ps, 'slice', '1/3 semitone', 'pcs Suppressed simple tone salience matrix');
end
end

% % standardization (Y(k,m) - mu(k,m)) / sigma(k,m)
if feparam.enStandardization
wl = 18; % 3 * 12 / 2
Ss = standardization(Ss, wl);
end
if df && enPlot
myImagePlot(Ss, kk, ps, 'slice', '1/3 semitone', 'pcs Suppressed simple tone salience matrix');
end

% noise reduction process
if feparam.enPeakNoiseRed
nt = 0.1;
Ss = noteSalienceNoiseReduce(Ss, nt);
Sc = noteSalienceNoiseReduce(Sc, nt);
if df && enPlot
myImagePlot(Ss, kk, ps, 'slice', '1/3 semitone', 'noised reduced simple tone salience matrix');
% myImagePlot(Sc, kk, ps, 'slice', '1/3 semitone', 'noised reduced complex tone salience matrix');
end
end

if ~feparam.tuningBefore
% tuning algorithm, assuming numsemitones = 3
if feparam.globalTuning
    Ss = globalTuning(Ss);
    Sc = globalTuning(Sc);
else
    Ss = localTuning(Ss);
    Sc = localTuning(Sc);
end
Ss = Ss ./ max(max(Ss)); % global normalize
Sc = Sc ./ max(max(Sc)); % global normalize
if df && enPlot
myImagePlot(Ss, kk, ps, 'slice', '1/3 semitone', 'tuned simple tone salience matrix');
% myImagePlot(Sc, kk, ps, 'slice', '1/3 semitone', 'tuned complex tone salience matrix');
end
end

% nnls approximate note transcription - 3-semitones -> 1-semitone
if feparam.enNNLS || feparam.enNNLSPlus
Sapx = nnlsTrans(Ss,E,3);
if df && enPlot
myImagePlot(Sapx, kk, 1:numnotes, 'slice', 'semitone', 'nnls salience matrix');
end
end

% compute note salience matrix by combining 1/3 semitones into semitones

% sum all 3 bins
Sss3 = zeros(numnotes,nslices);
Scc3 = zeros(numnotes,nslices);
for i = 1:1:3
    Sss3 = Sss3 + Ss(i:3:end,:);
    Scc3 = Scc3 + Sc(i:3:end,:);
end
% S = Sss.*Scc;
p = 1:numnotes;
if df && enPlot
myImagePlot(Sss3, kk, p, 'slice', '1/3 semitone', 'Ss note salience matrix (sum 3 bins)');
% myImagePlot(Scc3, kk, p, 'slice', '1/3 semitone', 'Sc note salience matrix (sum 3 bins)');
end

% alternatively, we could just take every center bins
SssC = Ss(2:3:end,:);
SccC = Sc(2:3:end,:);
if df && enPlot
myImagePlot(SssC, kk, p, 'slice', '1/3 semitone', 'Ss note salience matrix (center bin)');
% myImagePlot(SccC, kk, p, 'slice', '1/3 semitone', 'Sc note salience matrix (center bin)');
end

% interface with output S
if feparam.enNNLSPlus
    if feparam.enCenterbin
        S = SssC.*Sapx + SssC.*SccC;
    else 
        S = Sss3.*Sapx + Sss3.*Scc3;
    end
elseif feparam.enNNLS
    S = Sapx;
else
    if feparam.enCenterbin
        S = SssC.*SccC;
    else 
        S = Sss3.*Scc3;
    end
end
S = normalizeGram(S);
if df && enPlot
myImagePlot(S, kk, p, 'slice', 'semitone', 'note salience matrix');
end
