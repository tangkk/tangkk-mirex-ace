% CPRSA - Chord Progression Recognition System A
% This implements a machine listening method for recognizing the chords
% and chord progression boundaries within a piece of music

% ********************************************************** %
% ********************* Input ****************************** %
% ********************************************************** %
close all;
clear;
clc;

% global control variables
feedbackpause = 0;
usemono = false;
df = true;
grainsize = 1;

% input stage
display('input stage -- read audio from path');


artist = 'demoartist';
album = 'demoalbum';
songtitle = 'demosong';

audioroot = './audio/';
audiofolder = strcat(audioroot, artist,'/',album,'/');
audiopath = [audiofolder songtitle '.mp3'];

cproot = './cp/';
cpfolder = strcat(cproot, artist,'/',album,'/');
cppath = [cpfolder songtitle '.txt'];

gtroot = './gt/';
gtfolder = strcat(gtroot, artist,'/',album,'/');
gtpath = [gtfolder songtitle '.lab']; % '.lab' is the ground-truth

[x, fs] = myInput(audiopath, usemono);

% ********************************************************** %
% ********************* Front End ************************** %
% ********************************************************** %
display('frontend -- from input to harmonic salience matrix');

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
myImagePlot(X, kk, ff, 'slice', 'Hz', 'spectrogram');

fmin = 27.5; % MIDI note 21, Piano key number 1
fmax = 1661; % MIDI note 92, Piano key number 72
fratio = 2^(1/36);
numtones = 72*3;
[Ms,Mc] = toneProfileGen(wl, numtones, fmin, fmax, fratio, fs);
% myImagePlot(Ms, wl/2, numtones, 'time', '1/3 semitone', 'simple tone profile');
% myImagePlot(Mc, wl/2, numtones, 'time', '1/3 semitone', 'complex tone profile');

% calculate note salience matrix of the stft spectrogram (cosine
% similarity) (note that this is an additive approach, as contrast to
% the nnls approach which is an deductive approach)
Ss = Ms*X;
Sc = Mc*X;
Spre = Sc.*Sc;
sizeM = size(Ms);
ps = 1:sizeM(1);
myImagePlot(Ss, kk, ps, 'slice', '1/3 semitone', 'simple tone salience matrix');
myImagePlot(Sc, kk, ps, 'slice', '1/3 semitone', 'complex tone salience matrix');
myImagePlot(Spre, kk, ps, 'slice', '1/3 semitone', 'preliminary salience matrix');

% noise reduction process
nt = 0.1;
Ssn = noteSalienceNoiseReduce(Ss, nt);
Scn = noteSalienceNoiseReduce(Sc, nt);
Spren = Ssn.*Scn;
myImagePlot(Ssn, kk, ps, 'slice', '1/3 semitone', 'noised reduced simple tone salience matrix');
myImagePlot(Scn, kk, ps, 'slice', '1/3 semitone', 'noised reduced complex tone salience matrix');
myImagePlot(Spren, kk, ps, 'slice', '1/3 semitone', 'pre salience matrix');

% long salience compensation process
st = 0.1;
bb = 28; % bass bound, only compensate below bb
wgmax = 10;
Spren = compensateLongSalience(Spren,wgmax,st,bb);
myImagePlot(Spren, kk, ps, 'slice', '1/3 semitone', 'compensated pre salience matrix');

% short salience reduction process
st = 0.0;
bb = 28; % bass bound, only reduce below bass
wgmax = 5;
Spren = reduceShortSalience(Spren,wgmax,st,bb);
myImagePlot(Spren, kk, ps, 'slice', '1/3 semitone', 'reduced pre salience matrix');

% computer note salience matrix by combining 1/3 semitones into semitones
S = Spren(1:3:end,:) + Spren(2:3:end,:) + Spren(3:3:end,:);
sizeS = size(S);
ntones = sizeS(1);
S = normalizeGram(S);
p = 1:ntones;
myImagePlot(S, kk, p, 'slice', 'semitone', 'note salience matrix');

% gestaltize the note salience matrix
wgmax = 10;
st = 0.0;
Sg = gestaltNoteSalience(S,wgmax, st);
% myImagePlot(Sgpos, kk, p, 'slice', 'semitone', 'positive gestalt note salience matrix');
% myImagePlot(Sgneg, kk, p, 'slice', 'semitone', 'negative gestalt note salience matrix');
myImagePlot(Sg, kk, p, 'slice', 'semitone', 'gestalt note salience matrix');

% onset filter (roughly detect the note onsets)
ot = 0.0;
wo = 10;
So = noteOnsetFilter(Sg, ot, wo);
myImagePlot(So, kk, p, 'slice', 'semitone', 'note onset matrix');

% bassline filter (roughly set the dynamic bass bounds)
bt = 0.0;
wb = 10;
cb = 1;
Sb = bassLineFilter(Sg, bt, wb, cb);
myLinePlot(1:length(Sb), Sb, 'slice', 'semitone',nslices, ntones, '*', 'rough bassline');

% harmonic change filter (detect harmonic change boundaries)ht = 0.1;
ht = 0.1;
bc = 6;
[Sh, Shv, Shc, nchords] = harmonicChangeFilter(Sg, Sb, So, ht, bc);
myImagePlot(Sh, kk, p, 'slice', 'semitone', 'harmonic bounded salience matrix');
myImagePlot(Shv, kk(1:nchords), p, 'chord progression order',...
    'semitone', 'harmonic change matrix');
myLinePlot(1:length(Shc), Shc, 'chord progression order', 'slice',...
    nchords, nslices, 'o', 'haromonic change moments');

% ********************************************************** %
% ********************* Mid End - A************************* %
% ********************************************************** %
display('midend-A -- uppergram and basegram');

% compute basegram and uppergram (based on harmonic change matrix)
basegram = computeBasegram(Shv);
uppergram = computeUppergram(Shv);
bassnotenames = {'N','C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
treblenotenames = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
kh = 1:nchords;
ph = 1:12;
myLinePlot(kh, basegram(1,:), 'chord progression order', 'semitone',...
    nchords, 12, 'o', 'basegram', 0:12, bassnotenames);
myImagePlot(uppergram, kh, ph, 'chord progression order', 'semitone',...
    'uppergram', ph,treblenotenames);

% ********************************************************** %
% ********************* Back End - A************************ %
% ********************************************************** %
display('backend-A -- chordmode');

chordmode = buildChordMode;

chordogram = computeChordogram(basegram, uppergram, chordmode);

[outchordogram, outbassgram, outtreblegram, outboundaries] = gramGeneration(chordogram, Shc);

[outchordogram, outbassgram, outtreblegram, outboundaries] = combineSameChords(outchordogram, outbassgram,...
    outtreblegram, outboundaries);

[outchordogram, outbassgram, outtreblegram, outboundaries] = eliminateShortChords(outchordogram, outbassgram,...
    outtreblegram, outboundaries, grainsize); 

[outchordogram, outbassgram, outtreblegram, outboundaries] = mergeSimilarChords(outchordogram, outbassgram,...
    outtreblegram, outboundaries, chordmode);

myLinePlot(1:length(outbassgram), outbassgram, 'chord progression order', 'semitone',...
    length(outbassgram), 12, 'o', 'outbassgram', 0:12, bassnotenames);
myLinePlot(1:length(outboundaries), outboundaries, 'chord progression order', 'slice',...
    length(outboundaries), nslices, 'o', 'outboundaries');

visualizeChordProgression(outchordogram, outbassgram, outboundaries);

% ********************************************************** %
% ********************* Feedback Once - A******************* %
% ********************************************************** %
if feedbackpause
    display('press enter to continue with the feedback stage...');
    pause;
end
% ****** feedback mid end ****** %
display('feedback-A -- use chord boundaries information to do it again');

ut = 1;
nt = 0.25;
[newbasegram, newuppergram] = updateBaseUpperGram(outboundaries, S, So, ut, nt);
kh = 1:length(newbasegram);
ph = 1:12;
myLinePlot(kh, newbasegram(1,:), 'chord progression order', 'semitone', nchords, 12, 'o', 'newbasegram', 0:12, bassnotenames);
myImagePlot(newuppergram, kh, ph, 'chord progression order', 'semitone', 'newuppergram', ph,treblenotenames);

% ****** feedback back end ****** %
newchordogram = computeChordogram(newbasegram, newuppergram, chordmode);

[newoutchordogram, newoutbassgram, newouttreblegram, newoutboundaries] = gramGeneration(newchordogram, outboundaries);

[newoutchordogram, newoutbassgram, newouttreblegram, newoutboundaries] = combineSameChords(newoutchordogram, newoutbassgram,...
    newouttreblegram, newoutboundaries);

[newoutchordogram, newoutbassgram, newouttreblegram, newoutboundaries] = eliminateShortChords(newoutchordogram, newoutbassgram,...
    newouttreblegram, newoutboundaries, grainsize);

[newoutchordogram, newoutbassgram, newouttreblegram, newoutboundaries] = mergeSimilarChords(newoutchordogram, newoutbassgram,...
    newouttreblegram, newoutboundaries, chordmode);

myLinePlot(1:length(newoutbassgram), newoutbassgram, 'chord progression order', 'semitone',...
    length(newoutbassgram), 12, 'o', 'newoutbassgram', 0:12, bassnotenames);
myLinePlot(1:length(newoutboundaries), newoutboundaries, 'chord progression order', 'slice',...
    length(newoutboundaries), nslices, 'o', 'newoutboundaries');

visualizeChordProgression(newoutchordogram, newoutbassgram, newoutboundaries);

% ********************************************************** %
% ********************* Input ****************************** %
% ********************************************************** %

writeChordProgression(cpfolder, cppath, nslices, hopsize, fs, newoutchordogram, newoutboundaries, endtime);

% ********************* End of System A ******************** %
display(strcat('end of system A recognizing:',audiopath));

if df
    close all;
end

% ********************************************************** %
% ********************* Evaluation - A******************* %
% ********************************************************** %
% The following evaluator is built from Johan's source code:
% https://github.com/jpauwels/MusOOEvaluator
%
% ACE Evaluation presets
% 
% Triads
% Tetrads
% TriadsInput
% TetradsOnly
% Bass
% Root
% ChromaRecall
% ChromaPrecision
% ChromaFmeasure
% Mirex2009
% Mirex2010
% 4TriadsInput
% 4TriadsOutput
% 6TriadsInput
% 6TriadsOutput
% MirexMajMin
% MirexMajMinBass
% MirexSevenths
% MirexSeventhsBass
% MirexRoot
outroot = './out/';
evaltype = 'MirexRoot';
evalout = [outroot album evaltype '.txt'];
evalcmd = ['eval --list evallist.txt --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout...
    ' --chords ' evaltype];
system(evalcmd);
