% Automatic Chord Estimation
% A ''bass centric + gestalt'' approach

% ********************************************************** %
% ********************* Batch Input ************************ %
% ********************************************************** %
warning off;
installbnt;
path(path,genpath(fullfile(['.' '/' 'funcs'])));
warning on;
close all;
clear;
% clc;

% ********************************************************** %
% ********************* Control Panel ********************** %
% ********************************************************** %
% ****** output control ****** %
isexamine = 0; % 0: full evaluation, 1: examine segments

df = isexamine;
enPlotFE = 1;
enPlotBE = 1;
enEval = 1;
codec = 'mp3';

[feparam, beparam, dbnparam, dbn2param, chordmode] = paramInit();

% ********************************************************** %
% ********************* Process **************************** %
% ********************************************************** %
feval = fopen('evallist.txt','r');
tline = fgetl(feval);

while ischar(tline)

display('input...');

[audiofolder, audiopath, cpfolder, cppath] = inputDecode(tline, codec);

display('frontend...');

[bdrys, basegram, uppergram, endtime] = frontEndDecode(audiopath, feparam, df, enPlotFE);

display('backend...');

[rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys, df, enPlotBE);

if isexamine
    display(strcat('finish analyzing...',audiopath));
    break;
else
    display('output...');
    writeChordProgression(cpfolder, cppath, feparam.hopsize, feparam.fs,...
        rootgram, treblegram, bdrys, endtime, chordmode);
    display(strcat('finish analyzing...',audiopath));
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