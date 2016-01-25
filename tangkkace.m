% Automatic Chord Estimation
% main process

function tangkkace(paramN, acelist, savetmp)

if ischar(paramN)
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',paramN));
else
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',num2str(paramN)));
end

fe = fopen(acelist,'r');
tline = fgetl(fe);

rawbasegramSet = {};
rawuppergramSet = {};
bdrysSet = {};
saveidx = 1;
while ischar(tline)

    [inputpath, outputpath, songtitle] = inputDecode(tline);
    disp(['now start to analyze ' songtitle ' ......']);

    display('frontend...');

    [bdrys, basegram, uppergram, rawbasegram, rawuppergram, endtime] = frontEndDecode(inputpath, feparam, 0, 0);

    display('backend...');
    
    if savetmp % save intermediate results
        display(strcat('finish saving rawbasegram, rawuppergram, bdrys of ...',songtitle, ' !'));
        bdrys = savingDecode(chordmode, beparam, dbnparam, dbn2param, basegram, uppergram, bdrys);
        rawbasegramSet{saveidx} = rawbasegram;
        rawuppergramSet{saveidx} = rawuppergram;
        bdrysSet{saveidx} = bdrys;
        saveidx = saveidx + 1;
        tline = fgetl(fe);
        continue;
    end

    [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
        basegram, uppergram, rawbasegram, rawuppergram, bdrys, 0, 0);

    display('output...');
    writeOut(outputpath, feparam.hopsize, feparam.fs,...
        rootgram, treblegram, bdrys, endtime, chordmode);

    display(strcat('finish analyzing...',songtitle, ' !'));
    tline = fgetl(fe);

end % pair with the very first while loop

fclose(fe);

save('CaroleKingQueen26BUB.mat','rawbasegramSet','rawuppergramSet','bdrysSet','chordmode');
