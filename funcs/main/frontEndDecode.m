function [fs, nslices, endtime, S, btrack] = frontEndDecode(audiopath, tunpath, vamptunpath,...
    feparam, df, enPlot)

[x, fs] = myInput(audiopath, feparam.stereotomono);

% note dictionary
fmin = 27.5; % MIDI note 21, Piano key number 1 (A0)
fmax = 3322; % MIDI note 104, Piano key number nnotes
fratio = 2^(1/(12*3)); % nsemitones = 3
nnotes = 84;
ntones = nnotes*3; % nsemitones = 3
USR = 40; % upsampling rate

% FIXME: if the parameter changes, delete the '.mat' files and run again
if exist('dict.mat','file') == 2
load dict.mat;
else
[Ms,Mc] = toneProfileGen(feparam.overtoneS, feparam.wl, ntones, 3, fmin, fmax, fratio, fs);
E = nnlsNoteProfile(feparam.overtoneS, nnotes);
LE = logFreqNoteProfile(ntones, fmin, fratio, USR, fs, feparam.hopsize, feparam.wl/2);
save('dict.mat','Ms','Mc','E','LE');
end

if df && enPlot
myImagePlot(Ms, 1:feparam.wl/2, 1:ntones, 'dft bin', '1/3 semitone', 'simple tone profile');
myImagePlot(Mc, 1:feparam.wl/2, 1:ntones, 'dft bin', '1/3 semitone', 'complex tone profile');
myImagePlot(LE, 1:feparam.wl/2, 1:ntones, 'dft bin', '1/3 semitone', 'log freq note profile');
myImagePlot(E, 1:nnotes, 1:ntones, 'semitone', '1/3 semitone', 'nnls note profile');
end

% calculate note salience matrix of the stft spectrogram (cosine
% similarity) (note that this is an additive approach, as contrast to
% the nnls approach which is an deductive approach)
if ~feparam.enCQT
    % transform time domain into frequency domain
    X = mySpectrogram(x, feparam.wl, feparam.hopsize);
    nslices = size(X,2);
    endtime = (1/fs)*length(x);
    if df && enPlot
    myImagePlot(X, 1:nslices, 1:feparam.wl/2, 'slice', 'bin', 'spectrogram');
    end
    
    if feparam.enCosSim
    Ss = Ms*X;
    Sc = Mc*X;
    elseif feparam.enlogFreq
    Ss = LE*X;
    end
else
    Xcq = cqt(x, 36, fs, fmin*2^(-1/(12*3)), fmax*2^(1/(12*3)), 'rasterize', 'piecewise');
    Ss = full(abs(Xcq.c));
    feparam.hopsize = Xcq.xlen / size(Ss,2);
    nslices = size(Ss,2);
    endtime = (1/fs)*length(x);
end

if df && enPlot
myImagePlot(Ss.*10, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'simple tone salience matrix');
% myImagePlot(Sc, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'complex tone salience matrix');
end

% insert to test tunings
S = Ss; btrack = 0;
return;

if feparam.tuningBefore
% tuning algorithm, assuming nsemitones = 3
if feparam.globalTuning
    Ss = globalTuning(Ss);
    if feparam.enCosSim
    Sc = globalTuning(Sc);
    end
elseif feparam.localTuning
    Ss = localTuning(Ss);
    if feparam.enCosSim
    Sc = localTuning(Sc);
    end
elseif feparam.phaseTuning
    [Ss,~] = phaseTuning(Ss);
    if feparam.enCosSim
    [Sc,~] = phaseTuning(Sc);
    end
elseif feparam.gtTuning
    [Ss,~] = gtTuning(Ss, tunpath);
    if feparam.enCosSim
    [Sc,~] = gtTuning(Sc);
    end
elseif feparam.vampTuning
    [Ss,~] = vampTuning(Ss,vamptunpath);
    if feparam.enCosSim
    [Sc,~] = vampTuning(Sc);
    end
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'tuned simple tone salience matrix');
% myImagePlot(Sc, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'tuned complex tone salience matrix');
end
end

% suppress percussive moments
if feparam.enPcsSuppress
Ss = pcsSuppress(Ss, (max(sum(Ss))+mean(sum(Ss)))/2);
if feparam.enCosSim
Sc = pcsSuppress(Sc, (max(sum(Sc))+mean(sum(Sc)))/2);
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'pcs Suppressed simple tone salience matrix');
end
end

% % standardization (Y(k,m) - mu(k,m)) / sigma(k,m)
if feparam.enSUB
wl = 9; % 3 * 12 / 2
Ss = standardization(Ss, wl, feparam.enSTD, feparam.specWhitening, df);
if feparam.enCosSim
Sc = standardization(Sc, wl, feparam.enSTD, feparam.specWhitening, df);
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'standardized simple tone salience matrix');
end
end

% % insert to test tunings
% S = Ss; btrack = 0;
% return;

% noise reduction process
if feparam.enPeakNoiseRed
nt = 0.1;
Ss = noteSalienceNoiseReduce(Ss, nt);
if feparam.enCosSim
Sc = noteSalienceNoiseReduce(Sc, nt);
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'noised reduced simple tone salience matrix');
% myImagePlot(Sc, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'noised reduced complex tone salience matrix');
end
end

% interface to pre-salience matrix
if feparam.enCosSim
    Ss = Ss.*Sc;
end

if feparam.specRollOn > 0
Ss = specRollOn(Ss, feparam.specRollOn);
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'spec-roll-on simple tone salience matrix');
end
end

if ~feparam.tuningBefore
% tuning algorithm, assuming nsemitones = 3
if feparam.globalTuning
    Ss = globalTuning(Ss);
elseif feparam.localTuning
    Ss = localTuning(Ss);
elseif feparam.phaseTuning
    [Ss,~] = phaseTuning(Ss);
elseif feparam.gtTuning
    [Ss,~] = gtTuning(Ss, tunpath);
elseif feparam.vampTuning
    [Ss,~] = vampTuning(Ss,vamptunpath);
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'tuned simple tone salience matrix');
end
end

% nnls approximate note transcription - 3-semitones -> 1-semitone
if feparam.enNNLS
Sapx = nnlsTrans(Ss,E,3);
if df && enPlot
myImagePlot(Sapx, 1:nslices, 1:nnotes, 'slice', 'semitone', 'nnls salience matrix');
end
end

% compute note salience matrix by combining 1/3 semitones into semitones
% sum all 3 bins, alternatively, we could just take every center bins
Sss3bin = zeros(nnotes,nslices);
for i = 1:1:3
    Sss3bin = Sss3bin + Ss(i:3:end,:);
end
SssCen = Ss(2:3:end,:);
if df && enPlot
myImagePlot(Sss3bin, 1:nslices, 1:nnotes, 'slice', '1/3 semitone', 'Ss note salience matrix (sum 3 bins)');
myImagePlot(SssCen, 1:nslices, 1:nnotes, 'slice', '1/3 semitone', 'Ss note salience matrix (center bin)');
end

% interface with output S
if feparam.enCosSim % the baseline approach
    if feparam.enCenterbin
        S = SssCen;
    else 
        S = Sss3bin;
    end
elseif feparam.enNNLS % nnls
        S = Sapx;
end

if feparam.enProfiling
ht = hamming(nnotes);
hb = [hamming(nnotes/2);zeros(nnotes/2,1)];
mht = repmat(ht,1,nslices);
mhb = repmat(hb,1,nslices);
St = S .* mht;
Sb = S .* mhb;
if df && enPlot
myImagePlot(St, 1:nslices, 1:nnotes, 'slice', 'semitone', 'treble note salience matrix');
end
if df && enPlot
myImagePlot(Sb, 1:nslices, 1:nnotes, 'slice', 'semitone', 'bass note salience matrix');
end
end

% final normalization
S = normalizeGram(S,feparam.normalization);
if df && enPlot
myImagePlot(S, 1:nslices, 1:nnotes, 'slice', 'semitone', 'note salience matrix');
end

% beat tracking
btrackraw = getmeasures2(audiopath);
btrack = round(btrackraw.beats.*fs./feparam.hopsize + 1);
btrack(btrack > nslices) = nslices;
btrack(btrack == 0) = 1;

