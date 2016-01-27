% Automatic Chord Estimation
% main process

function tangkkace(paramN, acelist, savetmp, loadtmp)

if ischar(paramN)
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',paramN));
else
    [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',num2str(paramN)));
end

fe = fopen(acelist,'r');
tline = fgetl(fe);

savetmp = str2num(savetmp);
if nargin == 2
    savetmp = 0;
end
if savetmp == 2 && nargin == 4 % load tmp
    load(loadtmp);
    loadidx = 1;
end
if savetmp == 1 % save tmp
    rawbasegramSet = {};
    rawuppergramSet = {};
    bdrysSet = {};
    saveidx = 1;
end

while ischar(tline)

    [inputpath, outputpath, songtitle] = inputDecode(tline);
    disp(['now start to analyze ' songtitle ' ......']);
    
    if savetmp == 0
        display('frontend...');
        [bdrys, basegram, uppergram, rawbasegram, rawuppergram, endtime] = frontEndDecode(inputpath, feparam, 0, 0);
        display('backend...');
        [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
        basegram, uppergram, rawbasegram, rawuppergram, bdrys, 0, 0);
    elseif savetmp == 1 % save intermediate results
        display('frontend...');
        [bdrys, basegram, uppergram, rawbasegram, rawuppergram, endtime] = frontEndDecode(inputpath, feparam, 0, 0);
        bdrys = savingDecode(chordmode, beparam, dbnparam, dbn2param, basegram, uppergram, bdrys);
        rawbasegramSet{saveidx} = rawbasegram;
        rawuppergramSet{saveidx} = rawuppergram;
        bdrysSet{saveidx} = bdrys;
        saveidx = saveidx + 1;
        tline = fgetl(fe);
        display(strcat('finish saving rawbasegram, rawuppergram, bdrys of ...',songtitle, ' !'));
        continue;
    elseif savetmp == 2
        rawbasegram = rawbasegramSet{loadidx};
        rawuppergram = rawuppergramSet{loadidx};
        bdrys = bdrysSet{loadidx};
        loadidx = loadidx + 1;
        [rootgram, bassgram, treblegram] = loadingDecode(chordmode, beparam, rawbasegram, rawuppergram, bdrys);
    end
    
    display('output...');
    writeOut(outputpath, feparam.hopsize, feparam.fs,...
        rootgram, treblegram, bdrys, endtime, chordmode);

    display(strcat('finish analyzing...',songtitle, ' !'));
    tline = fgetl(fe);

end % pair with the very first while loop

fclose(fe);

save('CNPop20BUB.mat','rawbasegramSet','rawuppergramSet','bdrysSet','chordmode');
