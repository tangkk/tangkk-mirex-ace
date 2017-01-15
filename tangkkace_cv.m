% Automatic Chord Estimation
% main process

% original function: function tangkkace(paramN, testlist, savetmp, loadtmp, model)
% testing params example: 'mlp-JK-ch-6seg-800,800'
function tangkkace_cv(testingParams,putget)

strtoks = strsplit(testingParams,'-');
dnnmodel = strtoks{1};
dataset = strtoks{2};
featurelevel = strtoks{3};
segtile = strtoks{4};
netconfig = strtoks{5};


paramN = 'SB';

if strcmp(featurelevel,'ch')
    savetmp = 2;
elseif strcmp(featurelevel,'ns')
    savetmp = 6;
else
    savetmp = inf;
end

% extract nseg info
nseg = str2double(segtile(1:end-3));

% now perform cross validation testing
% first loop, loop folds
for cvi = 1:5
    if cvi == 1
        trainfolds = '2345';
    elseif cvi == 2
        trainfolds = '1345';
    elseif cvi == 3
        trainfolds = '1245';
    elseif cvi == 4
        trainfolds = '1235';
    elseif cvi == 5
        trainfolds = '1234';
    else
        trainfolds = '';
    end
    
    model = [dnnmodel, '-', dataset, '-', trainfolds, '-', featurelevel, '-', segtile, '-' netconfig, '.npz'];
    
    % second loop, loop datasets
    for dsi = 1:length(dataset)
        ts = dataset(dsi);
        if strcmp(ts,'C')
            thisset = 'CNPop20List';
        elseif strcmp(ts,'J')
            thisset = 'JayChou29List';
        elseif strcmp(ts,'K')
            thisset = 'CaroleKingQueen26List';
        elseif strcmp(ts,'U')
            thisset = 'USPop191List';
        elseif strcmp(ts,'R')
            thisset = 'RWC100List';
        elseif strcmp(ts,'B')
            thisset = 'TheBeatles180List';
        else
            thisset = '';
        end        
        
        testlist = ['data/cvlist/', thisset, '-', num2str(cvi), '.txt'];
        if strcmp(featurelevel,'ch')
            loadtmp = ['bub/', thisset, 'BUB', '-', num2str(cvi)];
        elseif strcmp(featurelevel,'ns')
            loadtmpch = ['bub/', thisset, 'BUB', '-', num2str(cvi)];
            loadtmpns = ['bub/', thisset, 'BUBns', '-', num2str(cvi)];
        else
            loadtmp = [];
            loadtmpch = [];
            loadtmpns = [];
        end

        if ischar(paramN)
            [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',paramN));
        else
            [feparam, beparam, dbnparam, dbn2param, chordmode] = feval(strcat('paramInit',num2str(paramN)));
        end

        fe = fopen(testlist,'r');
        tline = fgetl(fe);

        % load presaved matrice
        if savetmp == -1 % save tmp
            rawbasegramSet = {};
            rawuppergramSet = {};
            bdrysSet = {};
            endtimeSet = {};
            saveidx = 1;
        end
        if savetmp == -2
            nsSet = {};
            endtimeSet = {};
            saveidx = 1;
        end
        if savetmp == -3
            sgSet = {};
            endtimeSet = {};
            saveidx = 1;
        end
        if (savetmp == 1 || savetmp == 2 || savetmp == 3 || savetmp == 4)
            load(loadtmp);
            loadidx = 1;
        end
        if (savetmp == 5 || savetmp == 6)
            % load both BUB and BUBns
            load(loadtmpch);
            load(loadtmpns);
            loadidx = 1;
        end

        while ischar(tline)

            [inputpath, outputpath, songtitle] = inputDecode(tline);
            disp(['now start to analyze ' songtitle ' ......']);

            if savetmp == -3 % save intermediate results for sg models
                display('frontend...');
                [sg, endtime] = sgfrontEndDecode(inputpath, feparam, 0, 0);
                sgSet{saveidx} = sg;
                endtimeSet{saveidx} = endtime;
                saveidx = saveidx + 1;
                tline = fgetl(fe);
                display(strcat('finish saving sg of ...',songtitle, ' !'));
                continue;
            elseif savetmp == -2 % save intermediate results for ns models
                display('frontend...');
                [ns, endtime] = nsfrontEndDecode(inputpath, feparam, 0, 0);
                nsSet{saveidx} = ns;
                endtimeSet{saveidx} = endtime;
                saveidx = saveidx + 1;
                tline = fgetl(fe);
                display(strcat('finish saving ns of ...',songtitle, ' !'));
                continue;
            elseif savetmp == -1 % save intermediate results for ch models
                display('frontend...');
                [bdrys, basegram, uppergram, rawbasegram, rawuppergram, endtime] = frontEndDecode(inputpath, feparam, 0, 0);
                bdrys = savingDecode(chordmode, beparam, dbnparam, dbn2param, basegram, uppergram, bdrys);
                rawbasegramSet{saveidx} = rawbasegram;
                rawuppergramSet{saveidx} = rawuppergram;
                bdrysSet{saveidx} = bdrys;
                endtimeSet{saveidx} = endtime;
                saveidx = saveidx + 1;
                tline = fgetl(fe);
                display(strcat('finish saving rawbasegram, rawuppergram, bdrys of ...',songtitle, ' !'));
                continue; 
            elseif savetmp == 0 % normal decode frontend + backend
                display('frontend...');
                [bdrys, basegram, uppergram, rawbasegram, rawuppergram, endtime] = frontEndDecode(inputpath, feparam, 0, 0);
                display('Gaussian-HMM backend...');
                [rootgram, bassgram, treblegram, bdrys] = backEndDecode(chordmode, beparam, dbnparam, dbn2param,...
                basegram, uppergram, rawbasegram, rawuppergram, bdrys, 0, 0);
            elseif savetmp == 1 % type-I decode (ch fix model with HMM backend)
                rawbasegram = rawbasegramSet{loadidx};
                rawuppergram = rawuppergramSet{loadidx};
                bdrys = 1:size(rawbasegram,2);
                loadidx = loadidx + 1;
                display('ch-NN-HMM backend...');
                [rootgram, bassgram, treblegram, bdrys] = nn1Decode(chordmode, model, beparam, dbn2param, rawbasegram, rawuppergram, bdrys);
            elseif savetmp == 2 % type-II decode (ch fix model with segmentation information provided by baseline method)
                display('ch-seg-NN backend...');
                rawbasegram = rawbasegramSet{loadidx};
                rawuppergram = rawuppergramSet{loadidx};
                bdrys = bdrysSet{loadidx};
                endtime = endtimeSet{loadidx};
                loadidx = loadidx + 1;
                if strcmp(putget,'put')
                    nnn2Decode_put(tline, rawbasegram, rawuppergram, bdrys, nseg);
                elseif strcmp(putget,'get')
                    [rootgram, bassgram, treblegram] = nnn2Decode_get(chordmode, tline, model, nseg);
                else
                    [rootgram, bassgram, treblegram] = nnn2Decode(chordmode, rawbasegram, rawuppergram, bdrys, model, nseg);
                end
            elseif savetmp == 3 % type-III decode (ch recurrent model songwise model decode)
                rawbasegram = rawbasegramSet{loadidx};
                rawuppergram = rawuppergramSet{loadidx};
                bdrys = 1:size(rawbasegram,2);
                endtime = endtimeSet{loadidx};
                loadidx = loadidx + 1;
                display('ch-song-RNN backend...');
                [rootgram, bassgram, treblegram, bdrys] = nn3Decode(chordmode, model, beparam, rawbasegram, rawuppergram, bdrys);
            elseif savetmp == 4 % type-IV decode (ns recurrent model songwise decode)
                ns = nsSet{loadidx};
                bdrys = 1:size(ns,2);
                endtime = endtimeSet{loadidx};
                loadidx = loadidx + 1;
                display('ns-song-RNN backend...');
                [rootgram, bassgram, treblegram, bdrys] = nn4Decode(chordmode, model, beparam, ns, bdrys);
            elseif savetmp == 5 % type-V decode (ns fix model with HMM backend)
                ns = nsSet{loadidx};
                bdrys = 1:size(ns,2);
                endtime = endtimeSet{loadidx};
                loadidx = loadidx + 1;
                display('ns-NN-HMM backend...');
                [rootgram, bassgram, treblegram, bdrys] = nn5Decode(chordmode, model, beparam, dbn2param, ns, bdrys);
            elseif savetmp == 6 % type-VI decode (ns fix model with segmentation information provided by baseline method)       
                display('ns-seg-NN backend...');
                ns = nsSet{loadidx};
                bdrys = bdrysSet{loadidx};
                endtime = endtimeSet{loadidx};
                loadidx = loadidx + 1;
                if strcmp(putget,'put')
                    nnn6Decode_put(tline, ns, bdrys, nseg);
                elseif strcmp(putget,'get')
                    [rootgram, bassgram, treblegram] = nnn6Decode_get(chordmode, tline, model, nseg);
                else
                    [rootgram, bassgram, treblegram] = nnn6Decode(chordmode, ns, bdrys, model, nseg);
                end
            end
            
            if ~strcmp(putget,'put')
                display('writing to output...');
                writeOut(outputpath, feparam.hopsize, feparam.fs,...
                    rootgram, treblegram, bdrys, endtime, chordmode);
            end

            display(strcat('finish analyzing...',songtitle, ' !'));
            tline = fgetl(fe);

        end % pair with the very first while loop

        fclose(fe);

        if savetmp == -1 % save tmp
            save(loadtmp,'rawbasegramSet','rawuppergramSet','bdrysSet','endtimeSet','chordmode');
        end
        if savetmp == -2
            save(loadtmp,'nsSet','endtimeSet','-v7.3');
        end
        if savetmp == -3
            save(loadtmp,'sgSet','endtimeSet','-v7.3');
        end
    end
    
    % test one time for each fold
    if strcmp(putget,'put')
        continue;
    else
        evalsuffix = [testingParams, '-', num2str(cvi)];
        evallistins = [dataset, '-', num2str(cvi)];
        evaluateCP_cv(evalsuffix,evallistins);
    end
end


