% Automatic Chord Estimation - to be called by shell process
% A ''bass centric + gestalt'' approach

% this function process one file at a time

function mirexace(inFile, outFile)

% ********************************************************** %
% ********************* Batch Input ************************ %
% ********************************************************** %
warning off;
installbnt;
path(path,genpath(fullfile('./funcs')));
warning on;

[feparam, beparam, dbnparam, dbn2param, chordmode] = paramInit();

[bdrys, basegram, uppergram, endtime] = frontEndDecode(inFile, feparam, 0, 0);

[rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys, 0, 0);

writeOut(outFile, feparam.hopsize, feparam.fs,...
    rootgram, treblegram, bdrys, endtime, chordmode);

exit;