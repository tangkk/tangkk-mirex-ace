function [bdrys, basegram, uppergram, endtime] = frontEndDecode(audiopath, feparam, df, enPlot)

x = myInput(audiopath, feparam.stereotomono, feparam.fs);

display('input done...');

% we differentiate ''tone'' and ''note'' in this program
% by ''tone'' we mean 1/3-semitone-wise frequency, by ''note'' we mean
% semitone-wise frequency
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

display('spectrogram done...');

% note that using cosine similarity method there are both simple tone
% matrix (Ms) and complex tone matrix (Mc), the two are multiplied together
% to form the salience matrix. Thus CosSim is an additive process.
% also note that using log frequency spectrum method there is only one
% salience matrix at this stage, and this is just similar to the simple
% tone salience matrix. And the nnls process will infer note salience
% matrix from this later. Thus logFreq is an deductive process.
if feparam.enCosSim
Ss = Ms*X;
Sc = Mc*X;
elseif feparam.enlogFreq
Ss = LE*X;
end

if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'simple tone salience matrix');
if feparam.enCosSim
myImagePlot(Sc, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'complex tone salience matrix');
end
end

% tuning algorithms, assuming nsemitones = 3
if feparam.tuningBefore
[Ss,et] = phaseTuning(Ss);
if feparam.enCosSim
Sc = tuningUpdate(Sc,et);
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'tuned simple tone salience matrix');
if feparam.enCosSim
myImagePlot(Sc, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'tuned complex tone salience matrix');
end
end
end

display('tuning done...');

% spectral rollon
if feparam.specRollOn > 0
Ss = specRollOn(Ss, feparam.specRollOn);
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'spec-roll-on simple tone salience matrix');
end
end

% noise reduction process, normalize the matrix before processing
if feparam.enPeakNoiseRed
warning('off','signal:findpeaks:largeMinPeakHeight');
nt = 0.1;
nf = inf; % global normalization
[Ss, normVec] = normalizeGram(Ss, nf);
Ss = noteSalienceNoiseReduce(Ss, nt);
Ss = denormalizeGram(Ss, normVec);
if feparam.enCosSim
[Sc, normVec] = normalizeGram(Sc, nf);
Sc = noteSalienceNoiseReduce(Sc, nt);
Sc = denormalizeGram(Sc, normVec);
end
warning('on','signal:findpeaks:largeMinPeakHeight');
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'noised reduced simple tone salience matrix');
if feparam.enCosSim
myImagePlot(Sc, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'noised reduced complex tone salience matrix');
end
end
end

% interface to pre-salience matrix
if feparam.enCosSim
Ss = Ss.*Sc;
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'tone salience matrix');
end
end

if feparam.enToneGesComp
st = 0.0;
Ss = compensateLongSalience(Ss,feparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'positive gestalt tone salience matrix');
end
end

if feparam.enToneGesRed
st = 0.0;
Ss = reduceShortSalience(Ss,feparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'negative gestalt tone salience matrix');
end
end

% % standardization (Y(k,m) - mu(k,m)) / sigma(k,m)
if feparam.enSUB
Ss = standardization(Ss, feparam.stdwr, feparam.enSTD, feparam.specWhitening, df);
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'standardized simple tone salience matrix');
end
end

display('tonegram done...');

% nnls approximate note transcription - 3-semitones -> 1-semitone
if feparam.enNNLS
S = nnlsTrans(Ss,E,nnotes,feparam.enSigifBins);
elseif feparam.en3bin
S = Ss(1:3:end,:) + Ss(2:3:end,:) + Ss(3:3:end,:);
elseif feparam.enCenterbin
S = Ss(2:3:end,:);
end
if df && enPlot
myImagePlot(S, 1:nslices, 1:nnotes, 'slice', 'semitone', 'note salience matrix');
end

if feparam.enNoteGesComp
st = 0.0;
S = compensateLongSalience(S,feparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(S, 1:nslices, 1:nnotes, 'slice', 'semitone', 'positive gestalt note salience matrix');
end
end

if feparam.enNoteGesRed
st = 0.0;
S = reduceShortSalience(S,feparam.wgmax,st,0,0);
if df && enPlot
myImagePlot(S, 1:nslices, 1:nnotes, 'slice', 'semitone', 'negative gestalt note salience matrix');
end
end

display('notegram done...');

% use different segmentation methods
if feparam.noSegmentation
    bdrys = 1:nslices;
elseif feparam.useBassOnsetSegment
    bdrys = harmonicSegmentation(Ss, feparam.wgmax, 0, enPlot);
elseif feparam.useBeatSyncSegment
    % beat tracking
    btrackraw = getmeasures3(x,feparam.fs);
    btrack = round(btrackraw.beats ./ (feparam.hopsize * 44100 / feparam.fs));
    btrack(btrack > nslices) = nslices;
    btrack(btrack == 0) = 1;
    bdrys = btrack;
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

% compute basegram and uppergram (based on harmonic change matrix)
if feparam.basstreblechromagram
    if feparam.enProfileHann
    ht = hann(nnotes); ht = ht ./ norm(ht,1);
    hb = [hann(nnotes/2);zeros(nnotes/2,1)]; hb = hb ./ norm(hb,1);
    mht = repmat(ht,1,nsegs);
    mhb = repmat(hb,1,nsegs);
    Stout = Sseg .* mht;
    Sbout = Sseg .* mhb;
    elseif feparam.enProfileHamming
    ht = hamming(nnotes); ht = ht ./ norm(ht,1);
    hb = [hamming(nnotes/2);zeros(nnotes/2,1)]; hb = hb ./ norm(hb,1);
    mht = repmat(ht,1,nsegs);
    mhb = repmat(hb,1,nsegs);
    Stout = Sseg .* mht;
    Sbout = Sseg .* mhb;
    elseif feparam.enProfileRayleigh
    ht = raylpdf((1:nnotes)', nnotes/2); ht = ht ./ norm(ht,1);
    hb = raylpdf((1:nnotes)', nnotes/5); hb = hb ./ norm(hb,1);
    mht = repmat(ht,1,nsegs);
    mhb = repmat(hb,1,nsegs);
    Stout = Sseg .* mht;
    Sbout = Sseg .* mhb;
    end
    if df && enPlot
    myImagePlot(Stout, 1:nsegs, 1:nnotes, 'slice', 'semitone', 'treble note salience matrix');
    end
    if df && enPlot
    myImagePlot(Sbout, 1:nsegs, 1:nnotes, 'slice', 'semitone', 'bass note salience matrix');
    end
    % note this is to compute chromagram
    basegram = computeChromagram(Sbout);
    uppergram = computeChromagram(Stout);
    % normalize grams (whether global or local)
    [uppergram,~] = normalizeGram(uppergram,feparam.normalization);
    [basegram,~] = normalizeGram(basegram,feparam.normalization);
    % turn the zero columns to 1 columns
    uppergram = zero2one(uppergram);
    basegram = zero2one(basegram);
elseif feparam.baseuppergram
    basegram = computeBasegram(Sseg);
    uppergram = computeUppergram(Sseg);
    [uppergram,~] = normalizeGram(uppergram,feparam.normalization);
end



bassnotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
treblenotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
if df && enPlot
if feparam.baseuppergram
    myLinePlot(1:nsegs, basegram(1,:), 'segmentation progression order', 'semitone',...
    nsegs, 12, 'o', 'basegram', 1:12, bassnotenames);
end
if feparam.basstreblechromagram
myImagePlot(basegram, 1:nsegs, 1:12, 'segmentation progression order', 'semitone',...
    'basegram', 1:12, bassnotenames);
end
myImagePlot(uppergram, 1:nsegs, 1:12, 'segmentation progression order', 'semitone',...
    'uppergram', 1:12, treblenotenames);
end

display('chromagrams done...');
