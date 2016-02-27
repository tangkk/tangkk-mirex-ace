function [ns, endtime] = nsfrontEndDecode(audiopath, feparam, df, enPlot)

display('input in progress...');
x = myInput(audiopath, feparam.stereotomono, feparam.fs);

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
LE = logFreqNoteProfile(ntones, fmin, fratio, USR, feparam.fs, feparam.wl/2+1);
save('dict.mat','Ms','Mc','E','LE');
end

if df && enPlot
myImagePlot(Ms, 1:feparam.wl/2, 1:ntones, 'dft bin', '1/3 semitone', 'simple tone profile');
myImagePlot(Mc, 1:feparam.wl/2, 1:ntones, 'dft bin', '1/3 semitone', 'complex tone profile');
myImagePlot(LE, 1:feparam.wl/2, 1:ntones, 'dft bin', '1/3 semitone', 'log freq note profile');
myImagePlot(E, 1:nnotes, 1:ntones, 'semitone', '1/3 semitone', 'nnls note profile');
end

% CQT transform
% Xcq = cqt(x, 36, feparam.fs, fmin, fmax);
% x = icqt(Xcq);

% standard spectrogram transform
% Xsp = spectrogram(x, feparam.wl, feparam.wl-feparam.hopsize);
% x = istft(Xsp,feparam.hopsize,feparam.wl,feparam.fs);

% calculate note salience matrix of the stft spectrogram (cosine
% similarity) (note that this is an additive approach, as contrast to
% the nnls approach which is an deductive approach)
% transform time domain into frequency domain
display('computing spectrogram...');
X = mySpectrogram(x, feparam.wl, feparam.hopsize);
% X = abs(spectrogram(x, feparam.wl, feparam.wl-feparam.hopsize));
nslices = size(X,2);
endtime = (1/feparam.fs)*length(x);
if df && enPlot
myImagePlot(X, 1:nslices, 1:feparam.wl/2+1, 'slice', 'bin', 'spectrogram');
end

% note that using cosine similarity method there are both simple tone
% matrix (Ms) and complex tone matrix (Mc), the two are multiplied together
% to form the salience matrix. Thus CosSim is an additive process.
% also note that using log frequency spectrum method there is only one
% salience matrix at this stage, and this is just similar to the simple
% tone salience matrix. And the nnls process will infer note salience
% matrix from this later. Thus logFreq is an deductive process.
display('computing salience matrix...');
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

display('tuning...');
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

ns = Ss;