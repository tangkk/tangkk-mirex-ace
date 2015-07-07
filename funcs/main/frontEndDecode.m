function [bdrys, basegram, uppergram, nslices, endtime] = frontEndDecode(audiopath, tunpath, vamptunpath,...
    feparam, df, enPlot)

x = myInput(audiopath, feparam.stereotomono, feparam.fs);

fmin = 27.5; % MIDI note 21, Piano key number 1 (A0)
fmax = 3322; % MIDI note 104, Piano key number nnotes
fratio = 2^(1/(12*3)); % nsemitones = 3
nnotes = 84;
ntones = nnotes*3; % nsemitones = 3
USR = 80; % upsampling rate

% FIXME: if the parameter changes, delete the '.mat' files and run again
if exist('dict.mat','file') == 2
load dict.mat;
else

[Ms,Mc] = toneProfileGen(feparam.overtoneS, feparam.wl, ntones, 3, fmin, fmax, fratio, feparam.fs);
E = nnlsNoteProfile(feparam.overtoneS, nnotes, ntones);
% note that the size of one col of the spectrogram will be nfft/2 + 1,
% where nfft = feparam.wl (the hamming window size)
LE = logFreqNoteProfile(ntones, fmin, fratio, USR, feparam.fs, feparam.wl/2);
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
% transform time domain into frequency domain
X = mySpectrogram(x, feparam.wl, feparam.hopsize);
nslices = size(X,2);
endtime = (1/feparam.fs)*length(x);
if df && enPlot
myImagePlot(X, 1:nslices, 1:feparam.wl/2+1, 'slice', 'bin', 'spectrogram');
end

if feparam.enCosSim
Ss = Ms*X;
Sc = Mc*X;
elseif feparam.enlogFreq
Ss = LE*X;
end

if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'simple tone salience matrix');
% myImagePlot(Sc, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'complex tone salience matrix');
end

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
    [Sc,~] = gtTuning(Sc, tunpath);
    end
elseif feparam.vampTuning
    [Ss,~] = vampTuning(Ss,vamptunpath);
    if feparam.enCosSim
    [Sc,~] = vampTuning(Sc,vamptunpath);
    end
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'tuned simple tone salience matrix');
% myImagePlot(Sc, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'tuned complex tone salience matrix');
end
end

% spectral rollon
if feparam.specRollOn > 0
Ss = specRollOn(Ss, feparam.specRollOn);
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'spec-roll-on simple tone salience matrix');
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

% noise reduction process
if feparam.enPeakNoiseRed
nt = 0.1;
Ss = noteSalienceNoiseReduce(Ss, nt);
if feparam.enCosSim
Sc = noteSalienceNoiseReduce(Sc, nt);
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'noised reduced simple tone salience matrix');
% myImagePlot(Scn, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'noised reduced complex tone salience matrix');
end
end

if feparam.enGesComp
st = 0.0;
Ss = compensateLongSalience(Ss,feparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:nnotes, 'slice', 'semitone', 'positive gestalt note salience matrix');
end
end

if feparam.enGesRed
st = 0.0;
Ss = reduceShortSalience(Ss,feparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:nnotes, 'slice', 'semitone', 'negative gestalt note salience matrix');
end
end

% % standardization (Y(k,m) - mu(k,m)) / sigma(k,m)
if feparam.enSUB
Ss = standardization(Ss, feparam.stdwr, feparam.enSTD, feparam.specWhitening, df);
if feparam.enCosSim
Sc = standardization(Sc, feparam.stdwr, feparam.enSTD, feparam.specWhitening, df);
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'standardized simple tone salience matrix');
end
end

% interface to pre-salience matrix
if feparam.enCosSim
    Ss = Ss.*Sc;
end

% nnls approximate note transcription - 3-semitones -> 1-semitone
if feparam.enNNLS
S = nnlsTrans(Ss,E,nnotes,feparam.enSigifBins);
elseif feparam.en3bin
S = Ss(1:3:end,:) + Ss(2:3:end,:) + Ss(3:3:end,:);
elseif feparam.enCenterbin
S = Ss(2:3:end,:);
end
if df && enPlot
myImagePlot(S, 1:nslices, 1:nnotes, 'slice', 'semitone', 'nnls salience matrix');
end

% use different segmentation methods
if feparam.noSegmentation
    bdrys = 1:nslices;
elseif feparam.useBassOnsetSegment
    Shc = harmonicSegmentation(Ss, feparam.wgmax, 0, enPlot);
    bdrys = Shc;
elseif feparam.useWgSegment
    bdrys = 1:feparam.wgmax:nslices;
elseif feparam.useBeatSyncSegment
    % beat tracking
    btrackraw = getmeasures3(x,feparam.fs);
    btrack = round(btrackraw.beats ./ (feparam.hopsize * 44100 / feparam.fs));
    btrack(btrack > nslices) = nslices;
    btrack(btrack == 0) = 1;
    bdrys = btrack;
elseif feparam.useBassOnsetMedianSegment
    Shc = harmonicSegmentation(Ss, feparam.wgmax, 0, enPlot);
    bdrys = 1:round(median(Shc(2:end) - Shc(1:end-1))):nslices;
end

if bdrys(end) ~= nslices % including the end slice
    bdrys = [bdrys nslices];
end
if bdrys(1) ~= 1
    bdrys = [1 bdrys];
end

if feparam.noSegmentation
    Sseg = S;
else
    Sseg = zeros(size(S,1), length(bdrys) - 1);
    for j = 1:size(Sseg,2)
        if feparam.useMedianFilter
            Sseg(:,j) = median(S(:,bdrys(j):bdrys(j+1)),2);
        elseif feparam.useMeanFilter
            Sseg(:,j) = mean(S(:,bdrys(j):bdrys(j+1)),2);
        end
    end
end
if df && enPlot
myImagePlot(Sseg, 1:size(Sseg,2), 1:nnotes, 'segmentation',...
    'semitone', 'note salience segmentation matrix');
end

nnotes = size(Sseg,1);
nsegs = size(Sseg,2);
if feparam.enProfiling
ht = hann(nnotes); ht = ht ./ norm(ht,1);
hb = [hann(nnotes/2);zeros(nnotes/2,1)]; hb = hb ./ norm(hb,1);
mht = repmat(ht,1,nsegs);
mhb = repmat(hb,1,nsegs);
Stout = Sseg .* mht;
Sbout = Sseg .* mhb;
if df && enPlot
myImagePlot(Stout, 1:nsegs, 1:nnotes, 'slice', 'semitone', 'treble note salience matrix');
end
if df && enPlot
myImagePlot(Sbout, 1:nsegs, 1:nnotes, 'slice', 'semitone', 'bass note salience matrix');
end
end

% compute basegram and uppergram (based on harmonic change matrix)
if feparam.enProfiling && feparam.btchromagram
    % note this is to compute chromagram
    basegram = computeChromagram(Sbout);
    uppergram = computeChromagram(Stout);
elseif feparam.enProfiling
    basegram = computeBasegram(Sbout);
    uppergram = computeUppergram(Stout);
else
    basegram = computeBasegram(Sseg);
    uppergram = computeUppergram(Sseg);
end

% normalize grams (whether global or local)
uppergram = normalizeGram(uppergram,feparam.normalization);
basegram = normalizeGram(basegram,feparam.normalization);

% turn the zero columns to 1 columns
uppergram = zero2one(uppergram);
basegram = zero2one(basegram);

bassnotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
treblenotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
if df && enPlot
myImagePlot(basegram, 1:nsegs, 1:12, 'segmentation progression order', 'semitone',...
    'basegram', 1:12, bassnotenames);
myImagePlot(uppergram, 1:nsegs, 1:12, 'segmentation progression order', 'semitone',...
    'uppergram', 1:12, treblenotenames);
end
