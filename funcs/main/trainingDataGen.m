% Generate training data based on the ground truth files
% this process leverages the frontend and the ground truth data

acepath;
close all;
clear;

trainingDataName = 'trainingData-TheBeatles180.mat';

[feparam, ~, ~, ~, chordmode] = paramInit10();
fe = fopen('datalist.txt','r');
tline = fgetl(fe);

% the size of the training data is unknown yet. Will grow.
trainingDataX1 = zeros(1,252);
trainingDataX2 = zeros(1,24);
trainingDatay = zeros(1,1);
tidx = 1;

% transfer chordnames to chord nums
load chordnames.mat;
chordnums = chnames2chnums(chordnames, chordmode);

while ischar(tline)
    
    songpath = tline;
    pathtokens = strsplit(songpath,'/');
    artist = pathtokens{1};
    album = pathtokens{2};
    songname = pathtokens{3};

    audioroot = './audio/';
    audiofolder = strcat(audioroot, artist, '/', album);
    audiopath = [audiofolder '/' songname];
    
    sufposes = strfind(songname,'.');
    songtitle = songname(1:sufposes(end)-1);
    
    gtroot = './gt/';
    gtfolder = strcat(gtroot, artist, '/', album);
    gtpath = [gtfolder '/' songtitle '.lab'];
    
    display(['collecting training data of ' songtitle ' ......']);
    
    % ****** read audio content ****** %
    x = myInput(audiopath, feparam.stereotomono, feparam.fs);

    fmin = 27.5; % MIDI note 21, Piano key number 1 (A0)
    fmax = 3322; % MIDI note 104, Piano key number nnotes
    fratio = 2^(1/(12*3)); % nsemitones = 3
    nnotes = 84;
    ntones = nnotes*3; % nsemitones = 3
    USR = 80; % upsampling rate

    % FIXME: if the parameter changes, delete the '.mat' files and run again
    if exist('dict.mat','file') == 2
    load dict.mat;
    else
    [Ms,Mc] = toneProfileGen(feparam.overtoneS, feparam.wl, ntones, 3, fmin, fmax, fratio, feparam.fs);
    E = nnlsNoteProfile(feparam.overtoneS, nnotes, ntones);
    LE = logFreqNoteProfile(ntones, fmin, fratio, USR, feparam.fs, feparam.wl/2);
    save('dict.mat','Ms','Mc','E','LE');
    end

    X = mySpectrogram(x, feparam.wl, feparam.hopsize);
    nslices = size(X,2);
    endtime = (1/feparam.fs)*length(x);

    if feparam.enlogFreq
    Ss = LE*X;
    end

    % tuning algorithms, assuming nsemitones = 3
    if feparam.tuningBefore
    [Ss,etun] = phaseTuning(Ss);
    end
    
    % probing point for training data set 1
    Strain1 = Ss;

    % spectral rollon
    if feparam.specRollOn > 0
    Ss = specRollOn(Ss, feparam.specRollOn);
    end

    % % standardization (Y(k,m) - mu(k,m)) / sigma(k,m)
    if feparam.enSUB
    Ss = standardization(Ss, feparam.stdwr, feparam.enSTD, feparam.specWhitening, 0);
    end
    
    % nnls approximate note transcription - 3-semitones -> 1-semitone
    if feparam.enNNLS
    S = nnlsTrans(Ss,E,nnotes,feparam.enSigifBins);
    end
    
    % use different segmentation methods
    if feparam.noSegmentation
        bdrys = 1:nslices;
    end
    if feparam.noSegmentation
        Sseg = S;
    end
    nnotes = size(Sseg,1);
    nsegs = size(Sseg,2);

    % compute basegram and uppergram (based on harmonic change matrix)
    if feparam.basstreblechromagram
        if feparam.enProfileHann
        ht = hann(nnotes); ht = ht ./ norm(ht,1);
        hb = [hann(nnotes/2);zeros(nnotes/2,1)]; hb = hb ./ norm(hb,1);
        mht = repmat(ht,1,nsegs);
        mhb = repmat(hb,1,nsegs);
        Stout = Sseg .* mht;
        Sbout = Sseg .* mhb;
        elseif feparam.enProfileHamming
        ht = hamming(nnotes); ht = ht ./ norm(ht,1);
        hb = [hamming(nnotes/2);zeros(nnotes/2,1)]; hb = hb ./ norm(hb,1);
        mht = repmat(ht,1,nsegs);
        mhb = repmat(hb,1,nsegs);
        Stout = Sseg .* mht;
        Sbout = Sseg .* mhb;
        elseif feparam.enProfileRayleigh
        ht = raylpdf((1:nnotes)', nnotes/2); ht = ht ./ norm(ht,1);
        hb = raylpdf((1:nnotes)', nnotes/5); hb = hb ./ norm(hb,1);
        mht = repmat(ht,1,nsegs);
        mhb = repmat(hb,1,nsegs);
        Stout = Sseg .* mht;
        Sbout = Sseg .* mhb;
        end
        % note this is to compute chromagram
        basegram = computeChromagram(Sbout);
        uppergram = computeChromagram(Stout);
        % normalize grams (whether global or local)
        [uppergram,~] = normalizeGram(uppergram,feparam.normalization);
        [basegram,~] = normalizeGram(basegram,feparam.normalization);
        % turn the zero columns to 1 columns
        uppergram = zero2one(uppergram);
        basegram = zero2one(basegram);
    end
    
    % probing point for training data set 2
    Strain2 = [basegram ; uppergram];
    
    % ****** map audio content to gt****** %
    tw = ((feparam.hopsize/feparam.fs)*(1:bdrys(end))); % time ticks
    
    % there is a training data point at every ground truth line
    fg = fopen(gtpath,'r');
    gline = fgetl(fg);
    
    while ischar(gline)
        % decipher start time, end time and chord
        strtoks = strsplit(gline,' ');
        st = str2double(strtoks{1});
        et = str2double(strtoks{2});
        ch = strtoks{3};
        % take data bound from segmentation boundaries - [st,et]
        sb = databound(st, tw, 'st');
        eb = databound(et, tw, 'et');
        % cast chord to standard chords
        % FIXME: sus chords will all be cast to maj/1 chords
        nch = castGtLabel(ch);
        
        % grab data and make training point -
        % 1. salience matrix slices (take
        % Strain1), store the column training case in "tcase1"
        % 2. [uppergram; basegram], store the column training case in
        % "tcase2"
        % 3. store the ground truth label in tlabel
        % FIXME: tlabel 0 is for "N"
        Sm1 = Strain1(:,sb:eb);
        Sm2 = Strain2(:,sb:eb);
        tcase1 = normalizeGram(median(Sm1,2),inf); % feature normalization
        tcase2 = normalizeGram(median(Sm2,2),inf);
        chnum = chname2chnum(nch, chordmode);
        [~,tlabel] = ismember(chnum,chordnums);
        trainingDataX1(tidx,:) = tcase1';
        trainingDataX2(tidx,:) = tcase2';
        trainingDatay(tidx,:) = tlabel;
        
        gline = fgetl(fg);
        tidx = tidx + 1;
    end
    fclose(fg);
    tline = fgetl(fe);
end

% generate other training data for all 12 keys for every training data
% entry in X2
display('collecting training data for all 12 keys......');
trainingDataX12 = zeros(1,24);
trainingDatay12 = zeros(1,1);
t12idx = 1;
len = size(trainingDataX2,1);
for j = 1:len
    ocase = trainingDataX2(j,:);
    y = trainingDatay(j);
    for i = 0:11 % generate all other 11 keys (except for N chord)
        bcase = circshift(ocase(1:12)',i,1);
        ucase = circshift(ocase(13:24)',i,1);
        % generate a new data and a new label
        ncase = [bcase;ucase];
        if y ~= 0
            ochnum = chordnums{y};
        else
            ochnum = '0:0';
        end
        nchnum = chTranspose(ochnum, i);
        [~,nlabel] = ismember(nchnum,chordnums);
        trainingDataX12(t12idx,:) = ncase';
        trainingDatay12(t12idx,:) = nlabel;
        t12idx = t12idx + 1;
    end
end

% set label 0 to label length(chordnames)+1
trainingDatay(trainingDatay == 0) = length(chordnames)+1;
trainingDatay12(trainingDatay12 == 0) = length(chordnames)+1;

% save all the training data set collected
display('saving results......');
save(trainingDataName,'trainingDataX1','trainingDataX2','trainingDatay', 'trainingDataX12', 'trainingDatay12');

display('done......');
