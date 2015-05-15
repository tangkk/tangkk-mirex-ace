% Automatic Chord Estimation
% A ''bass centric + gestalt'' approach

% ********************************************************** %
% ********************* Batch Input ************************ %
% ********************************************************** %
path(path,genpath('.'));
close all;
clear;
clc;

% ********************************************************** %
% ********************* Control Panel ********************** %
% ********************************************************** %

% input control
stereotomono = false;
codec = 'mp3';

% output control
isexamine = 2; % 0: full evaluation, 1:examine range, 2: examine piece
runeval = 1;
examinerange = [15,30]; % start and endtime in unit of second
if isexamine
    df = true;
else
    df = false;
end

% optimization control
preGestaltCompensate = false;
preGestaltReduce = false;
enGestaltize = true;
wgmax = 10; % gestalt window size

% chored grain size control
grainsize = 1;

% chord vocabulary control
tetradcontrol = 0.3;
pentacontrol = 0.3;
hexacontrol = 0.3;
inversioncontrol = 0.3;

enDyad = 0;
enMajMin = 1;
enSusAdd = 1;
enSixth = 1;
enSeventh = 1;
enExtended = 1;
enAugDim = 1;
enMajMinBass = 1;
enSeventhBass = 1;
enOtherSlash = 0;

% chord casting control
enCast2MajMin = 1; % in case we'd like to substitute others to maj or min

feval = fopen('evallist.txt','r');
tline = fgetl(feval);

while ischar(tline)
    
% ********************************************************** %
% ********************* Input ****************************** %
% ********************************************************** %

% input stage
display('input...');

songpath = tline;
pathtokens = strsplit(songpath,'/');
artist = pathtokens{1};
album = pathtokens{2};
songtitle = pathtokens{3};

audioroot = './audio/';
audiofolder = strcat(audioroot, artist, '/', album);
audiopath = [audiofolder '/' songtitle '.' codec];

cproot = './cp/';
cpfolder = strcat(cproot, artist, '/', album);
cppath = [cpfolder '/' songtitle '.txt'];

gtroot = './gt/';
gtfolder = strcat(gtroot, artist, '/', album);
gtpath = [gtfolder '/' songtitle '.lab']; % '.lab' is the ground-truth

[x, fs] = myInput(audiopath, stereotomono, examinerange, isexamine);

% ********************************************************** %
% ********************* Front End ************************** %
% ********************************************************** %
display('frontend...');

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
if df
myImagePlot(X, kk, ff, 'slice', 'Hz', 'spectrogram');
end

fmin = 27.5; % MIDI note 21, Piano key number 1
fmax = 1661; % MIDI note 92, Piano key number numnotes
numsemitones = 3;
fratio = 2^(1/(12*numsemitones));
numnotes = 72;
numtones = numnotes*numsemitones;
[Ms,Mc] = toneProfileGen(wl, numtones, numsemitones, fmin, fmax, fratio, fs);
if df
myImagePlot(Ms, wl/2, numtones, 'time', '1/numsemitones semitone', 'simple tone profile');
myImagePlot(Mc, wl/2, numtones, 'time', '1/numsemitones semitone', 'complex tone profile');
end

% calculate note salience matrix of the stft spectrogram (cosine
% similarity) (note that this is an additive approach, as contrast to
% the nnls approach which is an deductive approach)
Ss = Ms*X;
Sc = Mc*X;
Spre = Sc.*Sc;
sizeM = size(Ms);
ps = 1:sizeM(1);
if df
myImagePlot(Ss, kk, ps, 'slice', '1/numsemitones semitone', 'simple tone salience matrix');
myImagePlot(Sc, kk, ps, 'slice', '1/numsemitones semitone', 'complex tone salience matrix');
myImagePlot(Spre, kk, ps, 'slice', '1/numsemitones semitone', 'preliminary salience matrix');
end

% tuning algorithm
Ss = tuning(Ss,numsemitones);
Sc = tuning(Sc,numsemitones);

% noise reduction process
nt = 0.1;
Ssn = noteSalienceNoiseReduce(Ss, nt);
Scn = noteSalienceNoiseReduce(Sc, nt);
Spren = Ssn.*Scn;
if df
myImagePlot(Ssn, kk, ps, 'slice', '1/numsemitones semitone', 'noised reduced simple tone salience matrix');
myImagePlot(Scn, kk, ps, 'slice', '1/numsemitones semitone', 'noised reduced complex tone salience matrix');
myImagePlot(Spren, kk, ps, 'slice', '1/numsemitones semitone', 'pre salience matrix');
end

if preGestaltCompensate
% long salience compensation process
st = 0.1;
bb = 28; % bass bound, only compensate below bb
% wgmax = 10;
Spren = compensateLongSalience(Spren,wgmax,st,bb,1);
if df
myImagePlot(Spren, kk, ps, 'slice', '1/numsemitones semitone', 'compensated pre salience matrix');
end
end

if preGestaltReduce
% short salience reduction process
st = 0.0;
bb = 28; % bass bound, only reduce below bass
% wgmax = 10;
Spren = reduceShortSalience(Spren,wgmax,st,bb,1);
if df
myImagePlot(Spren, kk, ps, 'slice', '1/numsemitones semitone', 'reduced pre salience matrix');
end
end

% computer note salience matrix by combining 1/numsemitones semitones into semitones
S = zeros(numnotes,nslices);
for i = 1:1:numsemitones
    S = S + Spren(i:numsemitones:end,:);
end
sizeS = size(S);
ntones = sizeS(1);
S = normalizeGram(S);
p = 1:ntones;
if df
myImagePlot(S, kk, p, 'slice', 'semitone', 'note salience matrix');
end

Sgo = S; % interface to another gestalt process

% gestaltize the note salience matrix
if enGestaltize
% wgmax = 10;
st = 0.0;
Sgo = gestaltNoteSalience(Sgo,wgmax, st);
end
if df
myImagePlot(Sgo, kk, p, 'slice', 'semitone', 'gestalt note salience matrix');
end

% if gestaltCompensate
% % gestaltize the note salience matrix
% % wgmax = 10;
% st = 0.0;
% Sgo = compensateLongSalience(Sgo,wgmax,st,0,0);
% if df
% myImagePlot(Sgo, kk, p, 'slice', 'semitone', 'positive gestalt note salience matrix');
% % myImagePlot(Sgneg, kk, p, 'slice', 'semitone', 'negative gestalt note salience matrix');
% end
% end
% 
% if gestaltReduce
% % wgmax = 10;
% st = 0.0;
% Sgo = reduceShortSalience(Sgo,wgmax,st,0,0);
% if df
% myImagePlot(Sg, kk, p, 'slice', 'semitone', 'gestalt note salience matrix');
% end
% end
%

% ********************************************************** %
% ********************* Mid End **************************** %
% ********************************************************** %
display('midend...');

Sg = Sgo; % interface to mid-end

% onset filter (roughly detect the note onsets)
ot = 0.0;
wo = 10;
So = noteOnsetFilter(Sg, ot, wo);
if df
myImagePlot(So, kk, p, 'slice', 'semitone', 'note onset matrix');
end

% bassline filter (roughly set the dynamic bass bounds)
bt = 0.0;
wb = 10;
cb = 1;
Sb = bassLineFilter(Sg, bt, wb, cb);
if df
myLinePlot(1:length(Sb), Sb, 'slice', 'semitone',nslices, ntones, '*', 'rough bassline');
end

% harmonic change filter (detect harmonic change boundaries)ht = 0.1;
ht = 0.1;
bc = 6;
[Sh, Shv, Shc, nchords] = harmonicChangeFilter(Sg, Sb, So, ht, bc);
if df
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
if df
myLinePlot(kh, basegram(1,:), 'chord progression order', 'semitone',...
    nchords, 12, 'o', 'basegram', 0:12, bassnotenames);
myImagePlot(uppergram, kh, ph, 'chord progression order', 'semitone',...
    'uppergram', ph,treblenotenames);
end

% ********************************************************** %
% ********************* Back End *************************** %
% ********************************************************** %
display('backend...');

chordmode = buildChordMode(tetradcontrol, pentacontrol, hexacontrol, inversioncontrol,...
    enDyad, enMajMin, enSusAdd,...
    enSixth, enSeventh, enExtended, enAugDim,...
    enMajMinBass, enSeventhBass, enOtherSlash);

chordogram = computeChordogram(basegram, uppergram, chordmode);

% the chord-level gestalt process
rootgram = chordogram(1,:); bassgram = chordogram(2,:); treblegram = chordogram(3,:); bdrys = Shc;

[rootgram, bassgram, treblegram, bdrys] = combineSameChords(rootgram, bassgram, treblegram, bdrys);

[rootgram, bassgram, treblegram, bdrys] = eliminateShortChords(rootgram,...
    bassgram, treblegram, bdrys, grainsize);

% compute note frequencies and tonic (dynamically), and do treble casting
hwin = 5; nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
[bassgram, treblegram] = castChords(nfSeq, bassgram, treblegram, chordmode);

[rootgram, bassgram, treblegram, bdrys] = mergeSimilarChords(rootgram,...
    bassgram, treblegram, bdrys, chordmode);

if df
myLinePlot(1:length(rootgram), rootgram, 'chord progression order', 'semitone',...
    length(rootgram), 12, 'o', 'rootgram', 0:12, bassnotenames);
myLinePlot(1:length(bassgram), bassgram, 'chord progression order', 'semitone',...
    length(bassgram), 12, 'o', 'bassgram', 0:12, bassnotenames);
myLinePlot(1:length(bdrys), bdrys, 'chord progression order', 'slice',...
    length(bdrys), nslices, 'o', 'boundaries');
visualizeChordProgression(rootgram, bassgram, treblegram, bdrys, chordmode);
end

% % ********************************************************** %
% % ********************* Feedback *************************** %
% % ********************************************************** %

fbn = 1; % feedback multiple times
for i = 1:1:fbn
    display(['feedback...' num2str(i)]);

    display('re-midend...');
    ut = 1;
    nt = 0.25;
    [basegram, uppergram] = updateBaseUpperGram(bdrys, S, So, ut, nt);
    
    % kh = 1:length(basegram);
    % ph = 1:12;
    % if df
    % myLinePlot(kh, basegram(1,:), 'chord progression order', 'semitone',...
    %   nchords, 12, 'o', 'newbasegram', 0:12, bassnotenames);
    % myImagePlot(uppergram, kh, ph, 'chord progression order', 'semitone',...
    %   'newuppergram', ph,treblenotenames);
    % end

    display('re-backend...');
    chordogram = computeChordogram(basegram, uppergram, chordmode);

    % the chord-level gestalt process
    rootgram = chordogram(1,:); bassgram = chordogram(2,:); treblegram = chordogram(3,:);

    [rootgram, bassgram, treblegram, bdrys] = combineSameChords(rootgram, bassgram, treblegram, bdrys);

    [rootgram, bassgram, treblegram, bdrys] = eliminateShortChords(rootgram,...
        bassgram, treblegram, bdrys, grainsize);

    % compute note frequencies and tonic (dynamically), and do treble casting
    hwin = 5; nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
    [bassgram, treblegram] = castChords(nfSeq, bassgram, treblegram, chordmode);

    [rootgram, bassgram, treblegram, bdrys] = mergeSimilarChords(rootgram,...
        bassgram, treblegram, bdrys, chordmode);
end

if df
myLinePlot(1:length(rootgram), rootgram, 'chord progression order', 'semitone',...
    length(rootgram), 12, 'o', 'rootgram', 0:12, bassnotenames);
myLinePlot(1:length(bassgram), bassgram, 'chord progression order', 'semitone',...
    length(bassgram), 12, 'o', 'bassgram', 0:12, bassnotenames);
myLinePlot(1:length(bdrys), bdrys, 'chord progression order', 'slice',...
    length(bdrys), nslices, 'o', 'boundaries');
visualizeChordProgression(rootgram, bassgram, treblegram, bdrys, chordmode);
end

% ********************************************************** %
% ***************** Tonic Computation ********************** %
% ********************************************************** %

% compute note frequencies and tonic (dynamically)
hwin = 5;
nfSeq = calNoteFreq(bassgram, treblegram, chordmode, hwin);
scaleSeq = calNoteScale(nfSeq);
tonicSeq = calTonic(scaleSeq);
display('tonic sequence:');
display(tonicSeq);

% ********************************************************** %
% ********************* Output ***************************** %
% ********************************************************** %

if isexamine
    break;
else
    display('output...');
    writeChordProgression(cpfolder, cppath, nslices, hopsize, fs, chordogram, bdrys, endtime);
    tline = fgetl(feval);
end

end % pair with the very first while loop

fclose(feval);

% ********************************************************** %
% ********************* Evaluation ************************* %
% ********************************************************** %
if runeval && ~isexamine
    display('evaluation...');
    evaluate;
end

% ********************************************************** %
% ********************* Playback *************************** %
% ********************************************************** %
if isexamine == 2
    display('playback...');
    p = audioplayer(x,fs);
    play(p);
end

display(strcat('end of system analyzing...',audiopath));
