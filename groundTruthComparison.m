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

% read groundtruth output into bassgram, treblegram and boundaries
[gtbassgram, gttreblegram, gttreblenames, gtboundaries] = parseOutput(gtpath);

% read cprs output into bassgram, treblegram and boundaries
[cpbassgram, cptreblegram, cptreblenames, cpboundaries] = parseOutput(cppath);

TD = gtboundaries(end); % total duration
BE = median(gtboundaries(2:end) - gtboundaries(1:end-1)) / 4; % boundary error

% compare gt with cp
cpbrco = computeBRCO(gtbassgram, gtboundaries, cpbassgram, cpboundaries, TD);
cptrco = computeTRCO(gttreblegram, gtboundaries, cptreblegram, cpboundaries, TD);
cprco = computeRCO(gtbassgram, gttreblegram, gtboundaries, cpbassgram, cptreblegram, cpboundaries, TD);
cpsq = computeSQ(gtboundaries, cpboundaries, BE);

display(cppath);
r = [cpbrco, cptrco, cpsq, cprco];
display('brco | trco | sq | rco');
display(r);
