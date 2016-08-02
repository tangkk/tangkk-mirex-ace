% ***********************************************************************
% enNNLS, specWhitening, enProfileHamming, DBN1
% enTheanoNN = 1
% This param supports both type-I and type-II systems
% FIXME: use Rayleigh when the statistic toolbox is available
%
% enTheanoNN
% btcVersion = 31
%
% enMajMin, enSeventh, enMajBass, enMinBass, enSeventhBass

function [feparam, beparam, dbnparam, dbn2param, chordmode] = paramInitJazzAll()

% ****** front-end control ****** %
feparam = struct(...
    ... % input parameters
    'stereotomono', 1,...
    ... % spectrogram parameters
    'fs',11025,... (default: 11025)
    'wl',4096,... (default: 4096)
    'hopsize',512,... (default: 512)
    ... % log-frequency spectrum
    'enlogFreq', 1,...
    'enCosSim', 0,...
    'overtoneS', 0.7,... % (default: 0.7)
    ... % tuning selection
    'tuningBefore', 1,...
    ... % noise reduction
    'specRollOn',0.01,... % 0 - 0.1 (default: 0.01)
    'enPeakNoiseRed', 0,...
    ... % tone level gestaltize
    'wgmax', 10,... % (default: 10)
    'enToneGesComp', 0,...
    'enToneGesRed', 0,...
    ... % standardization
    'enSUB', 1,...
    'enSTD', 1,...
    'stdwr', 18,... % (default: 18)
    'specWhitening', 1,... % 0 - 1 (default: 1.00)
    ... % 3 semitone -> 1 semitone processes
    'enSigifBins', 1,...
    'enNNLS', 1,...
    'enCenterbin', 0,...
    'en3bin', 0,...
    ... % note level gestalize (wgmax is set above)
    'enNoteGesComp', 0,...
    'enNoteGesRed', 0,...
    ... % segmentation
    'noSegmentation',1,...
    'useBassOnsetSegment', 0,...
    'useBeatSyncSegment', 0,...
    ... % filter selection
    'useMedianFilter', 1,...
    'useMeanFilter', 0,...
    ... % bass, treble profiling
    'basstreblechromagram', 1,...
    'baseuppergram', 0,...
    ... % window selection
    'enProfileHann', 0,...
    'enProfileHamming', 1,...
    'enProfileRayleigh', 0,...
    ... % normalization
    'normalization', inf);
% ****** Back-end control ****** %
beparam = struct(...
    ... % normalization
    'normalization', inf,...
    ...
    'useSIM1', 0,... % work together with 'BassOnsetSegment'
    'useDBN1', 1,...
    'useDBN2', 0,...
    'enCast2MajMin', 0,...
    ...
    'enChordGestalt', 1,...
    'enCombSameChords', 1,...
    'enEliminShortChords', 1,...
    'enMergeSimilarChords', 0,...
    'grainsize', 1,...
    ...
    ...
    'enBassTrebleCorrect', 1,... % work together with 'noSegmentation'
    'enTheanoNN', 1,... % 1: type-I or type-II, switched by savetmp setting
    'btcVersion', 30);
dbnparam = struct(...
    'muCBass',1,...
    'muNCBass',1,...
    'muTreble',1,...
    'muNoChord',1,...
    ...
    'sigma2Treble',0.2,...
    'sigma2CBass',0.1,...
    'sigma2NCBass',0.5,...
    'sigma2NoChord',0.2,...
    ...
    'selfTrans', 1e12);
dbn2param = struct(...
    'mu', 1,...
    'sigma', 0.1,...
    ...
    'wTreble', 1,...
    'wCBass', 1,...
    'wNCBass', 0.5,...
    ...
    'selfTrans', 1e12);

% use jazz chordmode
load chordmode-jazz-all.mat;
% chordmode = buildChordMode(chordmodeparam);