% Automatic Chord Estimation
% A ''bass centric + gestalt'' approach

% ********************************************************** %
% ********************* Batch Input ************************ %
% ********************************************************** %
warning off;
installbnt;
path(path,genpath(fullfile('./funcs')));
warning on;
close all;
clear;
% clc;

% ********************************************************** %
% ********************* Control Panel ********************** %
% ********************************************************** %
% ****** input control ****** %
codec = 'mp3';
% ****** front-end control ****** %
feparam = struct(...
    'wl',4096,...
    'hopsize',1024,...
    ...
    'enlogFreq', 1,...
    'enCQT', 0,...
    ...
    'overtoneS', 0.7,...
    'enPcsSuppress', 0,...
    'enSUB', 1,...
    'enSTD', 1,...
    'normalization', 2,...
    'specRollOn',0.01,... % 0 - 0.1
    'specWhitening', 1,... % 0 - 1
    'enPeakNoiseRed', 0,...
    ...
    'tuningBefore', 1,...
    'globalTuning', 0,...
    'localTuning', 0,...
    'phaseTuning',1,...
    'gtTuning',0,...
    'vampTuning',0,...
    ...
    'enProfiling', 0,...
    'enCosSim', 0,...
    'enNNLS', 1,...
    'enCenterbin', 1,...
    ...
    'stereotomono', 0);
% ****** Mid-end control ****** %
meparam = struct(...
    'enGesComp', 0,...
    'enGesRed', 0,...
    'wgmax', 0,...
    'normalization', 2,...
    ...
    'useBassOnsetSegment', 0,...
    'useBassOnsetMedianSegment', 0,...
    'useWgSegment', 0,...
    'useBeatSyncSegment', 1,...
    ...
    'enProfiling', 1,...
    ...
    'useMedianFilter', 0,...
    'useMeanFilter', 1,...
    ...
    'useOriginalSalience', 0,...
    'useGestaltSalience', 1,...
    ...
    'btchromagram', 1);
% ****** Back-end control ****** %
grainsize = 1;
fbn = 0;
dbnparam = struct(...
    'muCBass',1,...
    'muNCBass',1,...
    'muTreble',1,...
    'muNoChord',1,...
    'sigma2Treble',0.2,...
    'sigma2CBass',0.1,...
    'sigma2NCBass',0.2,...
    'sigma2NoChord',0.2,...
    'selfTrans', 10);

% chordmode parameters
chordmodeparam = struct(...,
    'tetradcontrol', 1 / 3,...
    'pentacontrol', 1 / 4,...
    'hexacontrol',1 / 5,...
    'inversioncontrol', 1 / 3,...
    'enUni', 0,...
    'enDyad', 0,...
    'enMajMin' , 1,...
    'enSusAdd' , 0,...
    'enSixth' , 1,...
    'enSeventh' , 1,...
    'enExtended' , 0,...
    'enAugDim' , 1,...
    'enMajMinBass' , 1,...
    'enSeventhBass' , 1,...
    'enOtherSlash' , 0);
enCast2MajMin = 0; % in case we'd like to substitute others to maj or min
chordmode = buildChordMode(chordmodeparam);

% ****** output control ****** %
isexamine = 0; % 0: full evaluation, 1: examine segments
df = isexamine;
enPlotFE = 1;
enPlotME = 1;
enPlotBE = 1;
enPlotFB = 1;
enPlotTS = 1;
enEval = 0;

% ********************************************************** %
% ********************* Process **************************** %
% ********************************************************** %
feval = fopen('evallist.txt','r');
tline = fgetl(feval);

tuns = cell(180,5);
tuni = 1;

while ischar(tline)

display('input...');

[audiofolder, audiopath, cpfolder, cppath,...
    gtfolder, gtpath, gttunpath, vamptunpath] = inputDecode(tline, codec);

display('frontend...');

[fs, nslices, endtime, S, btrack] = frontEndDecode(audiopath, gttunpath, vamptunpath,...
    feparam, df, enPlotFE);

% just insert to test tunings:
display(audiopath);
tokens = strsplit(audiopath,'/');
audioname = tokens{5}; audioname = audioname(1:end-4);
[~,gttun] = gtTuning(S, gttunpath);
[~,phasetun] = phaseTuning(S);
[~,vamptunpath] = vampTuning(S, vamptunpath);
tuns{tuni,1} = audioname;
tuns{tuni,2} = gttun;
tuns{tuni,3} = phasetun;
tuns{tuni,4} = vamptunpath;
tuns{tuni,5} = fs;
tuni = tuni + 1;
tline = fgetl(feval);
continue;

display('midend...');

[bdrys, basegram, uppergram] = midEndDecode(S, btrack, meparam, df, enPlotME);

display('backend...');

[rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, dbnparam,...
    basegram, uppergram, bdrys, grainsize, enCast2MajMin, nslices, df, enPlotBE);

% ****** reiterate the process until converge ******%
% for i = 1:1:fbn
% display(['feedback...' num2str(i)]);
% [basegram, uppergram] = updateBaseUpperGram(bassgram, bdrys, S, So, 1, 0.25);
% 
% [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, dbnparam,...
%     basegram, uppergram, bdrys, grainsize, enCast2MajMin, nslices, df, enPlotFB);
% end

% ****** key progression by-product ******%
% [scaleSeq, tonicSeq] = tonicDecode(bassgram, treblegram, bdrys, chordmode,...
%     df, enPlotTS);

if isexamine
    display(strcat('end of analyzing...',audiopath));
    break;
else
    display('output...');
    writeChordProgression(cpfolder, cppath, nslices, feparam.hopsize, fs,...
        rootgram, treblegram, bdrys, endtime, chordmode);
    display(strcat('end of analyzing...',audiopath));
    tline = fgetl(feval);
end

end % pair with the very first while loop

fclose(feval);

% ********************************************************** %
% ********************* Evaluation ************************* %
% ********************************************************** %
if enEval && ~isexamine
    display('evaluation...');
    evaluateCP;
end

% ********************************************************** %
% ********************* Playback *************************** %
% ********************************************************** %
% if isexamine
%     display('playback...');
%     p = audioplayer(x,fs);
%     play(p);
% end