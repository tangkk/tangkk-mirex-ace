% Automatic Chord Estimation - to be called by shell process
% A ''bass centric + gestalt'' approach

% this function process a batch of files at a time

function mirexace_win(inFileList, outFileDir)

% ********************************************************** %
% ********************* Batch Input ************************ %
% ********************************************************** %
warning off;
installbnt;
path(path,genpath(fullfile(['.' '/' 'funcs'])));
warning on;

[feparam, beparam, dbnparam, dbn2param, chordmode] = paramInit();

% batch processing
feval = fopen(inFileList,'r');
inFile = fgetl(feval);
while ischar(inFile)

[bdrys, basegram, uppergram, endtime] = frontEndDecode(inFile, feparam, 0, 0);

[rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys, 0, 0);

outFile = outputDecode(inFile, outFileDir);
writeOut(outFile, feparam.hopsize, feparam.fs,...
    rootgram, treblegram, bdrys, endtime, chordmode);

display(strcat('finish analyzing...', inFile));
inFile = fgetl(feval);
end

exit;