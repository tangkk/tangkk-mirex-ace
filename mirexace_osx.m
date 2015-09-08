% Automatic Chord Estimation - to be called by shell process

% this function process one file at a time

function mirexace(inFile, outFile, paramN)

acepath;

if ischar(paramN)
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',paramN));
else
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',num2str(paramN)));
end

[feparam, beparam, dbnparam, dbn2param, chordmode] = paramInit();

display(strcat('start analyzing...', inFile));

[bdrys, basegram, uppergram, endtime] = frontEndDecode(inFile, feparam, 0, 0);

[rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
    basegram, uppergram, bdrys, 0, 0);

writeOut(outFile, feparam.hopsize, feparam.fs,...
    rootgram, treblegram, bdrys, endtime, chordmode);
	
display(strcat('finish analyzing...', inFile));