% Automatic Chord Estimation - to be called by shell process

% this function process a batch of files at a time

function mirexace_win(inFileList, outFileDir, paramN)

acepath;

if ischar(paramN)
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',paramN));
else
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',num2str(paramN)));
end

% batch processing
fe = fopen(inFileList,'r');
inFile = fgetl(fe);
while ischar(inFile)

display(strcat('start analyzing...', inFile));
[bdrys, basegram, uppergram, endtime] = frontEndDecode(inFile, feparam, 0, 0);

[rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys, 0, 0);

outFile = outputDecode(inFile, outFileDir);
writeOut(outFile, feparam.hopsize, feparam.fs,...
    rootgram, treblegram, bdrys, endtime, chordmode);

display(strcat('finish analyzing...', inFile));
inFile = fgetl(fe);
end

exit;