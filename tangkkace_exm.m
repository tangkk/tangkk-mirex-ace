% Automatic Chord Estimation - Examine only
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
df = 1;
enPlotFE = 1;
enPlotBE = 1;
enEval = 1;

% ********************************************************** %
% ********************* Process **************************** %
% ********************************************************** %

[feparam, beparam, dbnparam, dbn2param, chordmode] = paramInit();

feval = fopen('evallist.txt','r');
tline = fgetl(feval);

while ischar(tline)

display('input...');

[inputpath, outputpath] = inputDecode(tline);

display('frontend...');

[bdrys, basegram, uppergram, endtime] = frontEndDecode(inputpath, feparam, df, enPlotFE);

display('backend...');

[rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys, df, enPlotBE);

display(strcat('finish analyzing...',inputpath));
break;

end

fclose(feval);

% ********************************************************** %
% ********************* No Evaluation ********************** %
% ********************************************************** %