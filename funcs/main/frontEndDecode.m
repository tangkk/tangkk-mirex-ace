function [nslices, endtime, S, btrack] = frontEndDecode(audiopath, tunpath, vamptunpath,...
    feparam, df, enPlot)

x = myInput(audiopath, feparam.stereotomono, feparam.fs);

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

[Ms,Mc] = toneProfileGen(feparam.overtoneS, feparam.wl, ntones, 3, fmin, fmax, fratio, feparam.fs);
E = nnlsNoteProfile(feparam.overtoneS, nnotes);
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
if ~feparam.enCQT
    % transform time domain into frequency domain
    X = mySpectrogram(x, feparam.wl, feparam.hopsize);
%     X = abs(spectrogram(x, hann(feparam.wl), feparam.wl - feparam.hopsize));
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
% FIXME: CQT is not working as it should be
% elseif feparam.enCQT
% %     [~,et] = gtTuning([0;0;0], tunpath);
% %     ptun = (log(et / 440) / log(2)) * 36; % compensate for the tunings
%     Xcq = cqt(x, 36, feparam.fs, fmin*2^((-1)/(12*3)), fmax*2^((1)/(12*3)), 'rasterize', 'full');
%     Ss = full(abs(Xcq.c));
%     Ss = [zeros(1,size(Ss,2));Ss];
%     feparam.hopsize = Xcq.xlen / size(Ss,2);
%     nslices = size(Ss,2);
%     endtime = (1/feparam.fs)*length(x);
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
Ss = standardization(Ss, feparam.stdwr, feparam.enSTD, feparam.specWhitening, df);
if feparam.enCosSim
Sc = standardization(Sc, feparam.stdwr, feparam.enSTD, feparam.specWhitening, df);
end
if df && enPlot
myImagePlot(Ss, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'standardized simple tone salience matrix');
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

if df && enPlot
myImagePlot(S, 1:nslices, 1:nnotes, 'slice', 'semitone', 'note salience matrix');
end

% beat tracking
btrackraw = getmeasures3(x,feparam.fs);
btrack = round(btrackraw.beats ./ (feparam.hopsize * 44100 / feparam.fs));
btrack(btrack > nslices) = nslices;
btrack(btrack == 0) = 1;

