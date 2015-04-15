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

% function r = groundTruthComparison(target)
target = 'demo';
gtpath = strcat('gt/',target,'.gt.txt'); % groundtruth output path
cdpath = strcat('cd/',target,'.cd.txt'); % chordino output path
cppath = strcat('cp/',target,'.cp.txt'); % cprs output path

% read groundtruth output into bassgram, treblegram and boundaries
[gtbassgram, gttreblegram, gttreblenames, gtboundaries] = parseOutput(gtpath);

% read chordino output into bassgram, treblegram and boundaries
[cdbassgram, cdtreblegram, cdtreblenames, cdboundaries] = parseOutput(cdpath);

% read cprs output into bassgram, treblegram and boundaries
[cpbassgram, cptreblegram, cptreblenames, cpboundaries] = parseOutput(cppath);

TD = gtboundaries(end); % total duration
BE = median(gtboundaries(2:end) - gtboundaries(1:end-1)) / 4; % boundary error
% compare gt with cd
cdbrco = computeBRCO(gtbassgram, gtboundaries, cdbassgram, cdboundaries, TD);
cdtrco = computeTRCO(gttreblegram, gtboundaries, cdtreblegram, cdboundaries, TD);
cdrco = computeRCO(gtbassgram, gttreblegram, gtboundaries, cdbassgram, cdtreblegram, cdboundaries, TD);
cdsq = computeSQ(gtboundaries, cdboundaries, BE);

% compare gt with cp
cpbrco = computeBRCO(gtbassgram, gtboundaries, cpbassgram, cpboundaries, TD);
cptrco = computeTRCO(gttreblegram, gtboundaries, cptreblegram, cpboundaries, TD);
cprco = computeRCO(gtbassgram, gttreblegram, gtboundaries, cpbassgram, cptreblegram, cpboundaries, TD);
cpsq = computeSQ(gtboundaries, cpboundaries, BE);

display(target);
r = [cdbrco, cdtrco, cdrco, cdsq; cpbrco, cptrco, cprco, cpsq];
display('chordino: brco, trco, rco, sq:');
display(r(1,:));
display('cprs: brco, trco, rco, sq:');
display(r(2,:));