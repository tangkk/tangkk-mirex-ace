% Automatic Chord Estimation - with evaluation

function tangkkace(paramN, acelist)

% ********************************************************** %
% ********************* Process **************************** %
% ********************************************************** %
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

    [bdrys, basegram, uppergram, endtime] = frontEndDecode(inputpath, feparam, 0, 0);

    display('backend...');

    [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
        basegram, uppergram, bdrys, 0, 0);

    display('output...');
    writeOut(outputpath, feparam.hopsize, feparam.fs,...
        rootgram, treblegram, bdrys, endtime, chordmode);

    display(strcat('finish analyzing...',songtitle, ' !'));
    tline = fgetl(fe);

end % pair with the very first while loop

fclose(fe);
