% Generate training data based on the ground truth files
% this process leverages the frontend and the ground truth data

function trainingDataGenVarLen(savename, gtList, noinv)

[feparam, ~, ~, ~, ~] = paramInit10();
chordmode =  chordTypesGen;
fe = fopen(gtList,'r');
tline = fgetl(fe);

% the size of the training data is unknown yet.
% and since each training case does not necessary have the same length
% we use cell to store them
% note that we still use vector to store targets (labels)
trainingDataX1 = {};
trainingDataX2 = {};
trainingDatay = zeros(1,1);

if noinv
    load chordnames-noinv.mat;
else
    load chordnames-inv.mat;
end


chordnums = chnames2chnums(chordnames, chordmode);

tidx = 1;
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
%         % normalize grams (whether global or local)
%         [uppergram,~] = normalizeGram(uppergram,feparam.normalization);
%         [basegram,~] = normalizeGram(basegram,feparam.normalization);
%         % turn the zero columns to 1 columns
%         uppergram = zero2one(uppergram);
%         basegram = zero2one(basegram);
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
        if length(strtoks) == 1
            strtoks = strsplit(gline,'\t');
        end
        st = str2double(strtoks{1});
        et = str2double(strtoks{2});
        ch = strtoks{3};
        % take data bound from segmentation boundaries - [st,et]
        sb = databound(st, tw, 'st');
        eb = databound(et, tw, 'et');
        % cast chord to standard chords
        % FIXME: sus chords will all be cast to maj/1 chords
        % is this a desirable effect? Maybe...
        nch = castGtLabel(ch,noinv);
        chnum = chname2chnum(nch, chordmode);
        [~,tlabel] = ismember(chnum,chordnums);
        
        % grab data and make training point -
        % 1. salience matrix slices (take
        % Strain1), store the column training case in "tcase1"
        % 2. [uppergram; basegram], store the column training case in
        % "tcase2"
        % 3. store the ground truth label in tlabel
        % tlabel 0 is for "N" chord, follow the below code if want to know
        % why
        tcase1 = Strain1(:,sb:eb);
        tcase2 = Strain2(:,sb:eb);
        tcase1 = tcase1(:);
        tcase2 = tcase2(:);
        
        % store each segment (possibly of different length) into cells
        trainingDataX1{tidx,1} = tcase1';
        trainingDataX2{tidx,1} = tcase2';
        trainingDatay(tidx,:) = tlabel;
        
        gline = fgetl(fg);
        tidx = tidx + 1;
    end
    fclose(fg);
    tline = fgetl(fe);
end

% note that after the below process each entry of X will be flattened into one dim

% generate other training data for all 12 keys for every training data
% entry in X1 (252 dim feature - note salience)
display('collecting training data for all 12 keys in trainingDataX1......');

len = size(trainingDataX1,1);
trainingDataX11 = {};
trainingDatay11 = [];
idx = 1;
for i = 1:len
    Xi = trainingDataX1{i};
    yi = trainingDatay(i);
    if yi ~= 0
        ynum = chordnums{yi};
    else
        ynum = '0:0';
    end
    
    % neg transpose
    nseg = length(Xi) / 252;
    for j = 0:5
        TXi = [];
        for k = 1:nseg % transpose for all nseg sections
            Xt = Xi((k-1)*252+1:(k)*252);
            padlen = j*3;
            pad = zeros(1,padlen);
            TXt = [Xt(1+padlen:end) pad];
            TXi = [TXi TXt];
        end
        trainingDataX11{idx,1} = TXi;
        nynum = chTranspose(ynum, -j);
        [~,nyi] = ismember(nynum,chordnums);
        trainingDatay11(idx,:) = nyi;
        idx = idx + 1;
    end
    
    % pos transpose
    for j = 1:6
        TXi = [];
        for k = 1:nseg
            Xt = Xi((k-1)*252+1:(k)*252);
            padlen = j*3;
            pad = zeros(1,padlen);
            TXt = [pad Xt(1:end-padlen)];
            TXi = [TXi TXt];
        end
        trainingDataX11{idx,1} = TXi;
        nynum = chTranspose(ynum, j);
        [~,nyi] = ismember(nynum,chordnums);
        trainingDatay11(idx) = nyi;
        idx = idx + 1;
    end
end

% generate other training data for all 12 keys for every training data
% entry in X2 (24 dim feature - basstreble chroma)
display('collecting training data for all 12 keys in trainingDataX2......');
trainingDataX22 = {};
trainingDatay22 = [];
t12idx = 1;
len = size(trainingDataX2,1);
for j = 1:len
    ocase = trainingDataX2{j};
    y = trainingDatay(j);
    nseg = length(ocase) / 24;
    for i = 0:11 % generate all other 11 keys (except for N chord)
        ncase = zeros(24,nseg);
        for k = 1:nseg % generate for all nseg segments
            bcase = circshift(ocase(1+(k-1)*24:12+(k-1)*24)',i,1);
            ucase = circshift(ocase(13+(k-1)*24:24+(k-1)*24)',i,1);
            % generate a new data and a new label
            ncase(:,k) = [bcase;ucase];
        end
        
        if y ~= 0
            ochnum = chordnums{y};
        else
            ochnum = '0:0';
        end
        nchnum = chTranspose(ochnum, i);
        [~,nlabel] = ismember(nchnum,chordnums);
        trainingDataX22{t12idx,1} = ncase(:)';
        trainingDatay22(t12idx,:) = nlabel;
        t12idx = t12idx + 1;
    end
end


% set label 0 to label length(chordnames)+1
trainingDatay(trainingDatay == 0) = length(chordnames)+1;
trainingDatay11(trainingDatay11 == 0) = length(chordnames)+1;
trainingDatay22(trainingDatay22 == 0) = length(chordnames)+1;

% save all the training data set collected
display('saving results......');
save(savename,'trainingDataX1','trainingDataX2','trainingDatay',...
    'trainingDataX11', 'trainingDatay11',...
    'trainingDataX22', 'trainingDatay22','-v7.3');

display('done......');
