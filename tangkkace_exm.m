% Automatic Chord Estimation - examine only

function tangkkace(paramN, acelist)

if ischar(paramN)
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',paramN));
else
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',num2str(paramN)));
end

fe = fopen(acelist,'r');
tline = fgetl(fe);

while ischar(tline)

	[inputpath, outputpath, songtitle] = inputDecode(tline);
	disp(['now start to analyze ' songtitle ' ......']);

	display('frontend...');

	[bdrys, basegram, uppergram, endtime] = frontEndDecode(inputpath, feparam, 1, 1);

	display('backend...');

	[rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
		basegram, uppergram, bdrys, 1, 1);

	display(strcat('finish analyzing...',inputpath));
	
	break; % just examine once

end

fclose(fe);
