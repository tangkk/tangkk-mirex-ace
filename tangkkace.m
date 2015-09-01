% Automatic Chord Estimation - with evaluation
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
% ********************* Process **************************** %
% ********************************************************** %
[feparam, beparam, dbnparam, dbn2param, chordmode] = paramInit();

feval = fopen('evallist.txt','r');
tline = fgetl(feval);

while ischar(tline)

    display('input...');

    [inputpath, outputpath] = inputDecode(tline);

    display('frontend...');

    [bdrys, basegram, uppergram, endtime] = frontEndDecode(inputpath, feparam, 0, 0);

    display('backend...');

    [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
        basegram, uppergram, bdrys, 0, 0);

    display('output...');
    writeOut(outputpath, feparam.hopsize, feparam.fs,...
        rootgram, treblegram, bdrys, endtime, chordmode);

    display(strcat('finish analyzing...',inputpath));
    tline = fgetl(feval);

end % pair with the very first while loop

fclose(feval);

% ********************************************************** %
% ********************* Evaluation ************************* %
% ********************************************************** %
% display('evaluation...');
% evaluateCP('your suffix name');
