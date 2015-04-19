% compare the output of this algorithm with ground truth.
% the comparison goes with the following settings:
% bass relative correct overlap (brco) =
%   # bass matching frames / total # of frames
% treble relative correct overlap (trco) =
%   # treble matching frames / total # of frames
% chord relative correct overlap (rco) =
%   # chord matching frames / total # of frames
% segmentation quality (sq) =
%   # of correct boundaries / total # of boundaries
% chord progression quality (cpq) =
%   sum of # of frames of 3 longest matching sequence / total # of frames
%
% definition of correct bass matching:
%   bass 0 matches all
%   other basses match the same basses pitch (note the "#" and "b")
% definition of correct treble matching:
%   two treble matches if their types match
%   treble 'N' matches all
% definition of correct chord matching:
%   if both bass and treble match, they match
% definition of correct boundary:
%   a detected boundary within 1/10 of the median of gt boundary-diffs
% definition of significant difference between algorithms:
%   Friedman rank

% refer to: http://www.music-ir.org/mirex/wiki/2015:Audio_Chord_Estimation
% and the related articles in this website for further details about the
% comparison metrics

% There are totally 8 different measures:
% 1, root; 2,majmin; 3,majminbass; 4, seventh; 5, seventhbass 6,bass;
% 7, chroma recall/precision; 8,tetrad
% for example, here a email replied from Johan Pauwels:

% Mirex          Roots	MirexMajMin	MirexMajMinBass	MirexSevenths	MirexSeventhsBass	Bass	ChromaRecall/Precision	Tetrads
% Ref G/F	     G	    G:maj	    G:maj	        G:7	            G:7/b7	            F	    {B D F G}	            G:7
% Test F	     F	    F:maj	    F:maj	        F:maj	        F:maj	            F	    {A C F}	                F:maj
% Ref C:maj6	 C	    C:maj	    C:maj	        X (C:maj6)	    X (C:maj6)	        C	    {A C E G}	            C:maj6
% Test A:min7/b  A	    A:min	    A:min/b3	    A:min7	        A:min7/b3	        C	    {A C E G}	            A:min7

% function r = groundTruthComparison(gtpath)
gtroot = './gt/';
cproot = './cp/';
artist = 'demoartist';
album = 'demoalbum';
songtitle = 'demosong';

gtfolder = strcat(gtroot,artist,'/',album,'/');
gtpath = [gtfolder songtitle '.lab']; % '.lab' is the ground-truth

cpfolder = strcat(cproot,artist,'/',album,'/');
cppath = [cpfolder songtitle '.txt']; % '.txt' is the output of this system

outroot = './out/';
evaltype = 'MirexRoot';
evalout = [outroot album evaltype '.txt'];
evalcmd = ['eval --list evallist.txt --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout...
    ' --chords ' evaltype];
system(evalcmd);

% % read groundtruth output into bassgram, treblegram and boundaries
% [gtrootgram, gtbassgram, gtqualgram, gtboundaries] = parseOutput(gtpath);
% gtmajmin = computeMajMin(gtrootgram, gtbassgram, gtqualgram);
% gtmajminbass = computeMajMinBass(gtrootgram, gtbassgram, gtqualgram);
% gtsevenths = computeSevenths(gtrootgram, gtbassgram, gtqualgram);
% gtseventhsbass = computeSeventhsBass(gtrootgram, gtbassgram, gtqualgram);
% 
% % read cprs output into bassgram, treblegram and boundaries
% [cprootgram, cpbassgram, cpqualgram, cpboundaries] = parseOutput(cppath);
% cpmajmin = computeMajMin(cprootgram, cpbassgram, cpqualgram);
% cpmajminbass = computeMajMinBass(cprootgram, cpbassgram, cpqualgram);
% cpsevenths = computeSevenths(cprootgram, cpbassgram, cpqualgram);
% cpseventhsbass = computeSeventhsBass(cprootgram, cpbassgram, cpqualgram);
% 
% TD = gtboundaries(end); % total duration
% BE = median(gtboundaries(2:end) - gtboundaries(1:end-1)) / 4; % boundary error
% 
% % compare gt with cp
% % cpbrco = computeBRCO(gtbassgram, gtboundaries, cpbassgram, cpboundaries, TD);
% % cptrco = computeTRCO(gttreblegram, gtboundaries, cptreblegram, cpboundaries, TD);
% % cprco = computeRCO(gtbassgram, gttreblegram, gtboundaries, cpbassgram, cptreblegram, cpboundaries, TD);
% % cpsq = computeSQ(gtboundaries, cpboundaries, BE);
% % 
% % display(cppath);
% % r = [cpbrco, cptrco, cpsq, cprco];
% % display('brco | trco | sq | rco');
% % display(r);
