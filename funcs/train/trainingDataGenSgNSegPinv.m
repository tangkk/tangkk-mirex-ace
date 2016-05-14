% Generate training data based on the ground truth files
% this process leverages the frontend and the ground truth data

% spectrogram level
function trainingDataGenSgNSegPinv(savename, gtList, nseg, noinv, no7)

[feparam, ~, ~, ~, ~] = paramInit10();
chordmode =  chordTypesGen;
fe = fopen(gtList,'r');
tline = fgetl(fe);
nbin = 2049;

% the size of the training data is unknown yet. Will grow.
trainingDataX1 = zeros(1,nbin*nseg);
trainingDatay = zeros(1,1);
tidx = 1;

if noinv 
    load chordnames-noinv.mat;
elseif no7
    load chordnames-no7.mat;
else
    load chordnames-inv.mat;
end

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
    X = mySpectrogram(x, feparam.wl, feparam.hopsize);
    
    % probing point for training data set 1
    Strain1 = X;
    
    % ****** map audio content to gt****** %
    bdrys = 1:size(X,2);
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
        nch = castGtLabel(ch,noinv,no7);
        
        % grab data and make training point -
        % 3. store the ground truth label in tlabel
        % FIXME: tlabel 0 is for "N"
        Sm1 = Strain1(:,sb:eb);
        Sm1nseg = zeros(nbin,nseg);
        
        % seperate each segment into nseg sections (along time axis) and take average upon the
        % segments
        lenseg = eb-sb+1; % length of the whole segment
        lensec = max(floor(lenseg / nseg),1); % length of each section
        for i = 1:nseg
            Sm1sec = mean(Sm1(:,min((i-1)*lensec+1,lenseg): min(i*lensec,lenseg)),2);
            Sm1nseg(:,i) = Sm1sec;
        end
        
        % unroll the feature matrix to become a feature vector
        tcase1 = Sm1nseg(:);
        
        chnum = chname2chnum(nch, chordmode);
        [~,tlabel] = ismember(chnum,chordnums);
        trainingDataX1(tidx,:) = tcase1';
        trainingDatay(tidx,:) = tlabel;
        
        gline = fgetl(fg);
        tidx = tidx + 1;
    end
    fclose(fg);
    tline = fgetl(fe);
end

% generate other training data for all 12 keys for every training data
% entry in X1 (nbin dim feature - note salience)
display('collecting training data for all 12 keys in trainingDataX1......');

fmin = 27.5; % MIDI note 21, Piano key number 1 (A0)
fratio = 2^(1/(12*3)); % nsemitones = 3
nnotes = 84;
ntones = nnotes*3; % nsemitones = 3
USR = 80; % upsampling rate
% cirshift the matrix by first transform it to log-scale and then back to
% linear scale
LE = logFreqNoteProfile(ntones, fmin, fratio, USR, feparam.fs, feparam.wl/2+1);
PLE = pinv(LE);
nsbin = 252;

len = size(trainingDataX1,1);
% FIXME: preallocate the matrix for efficiency
trainingDataX11 = zeros(size(trainingDataX1,1)*12,size(trainingDataX1,2));
trainingDatay11 = zeros(size(trainingDatay,1)*12,1);
idx = 1;
for i = 1:len
    display(i);
    Xi = trainingDataX1(i,:);
    yi = trainingDatay(i);
    if yi ~= 0
        ynum = chordnums{yi};
    else
        ynum = '0:0';
    end
    
    % non transpose
    trainingDataX11(idx,:) = Xi;
    trainingDatay11(idx,:) = yi;
    idx = idx + 1;
    
    % FIXME: how to do the cirshift of spectrogram?
    % SOVLE: use LE to transform to log-scale then pinv(LE) to transform
    % back
    Xtemp = [];
    for k = 1:nseg
        Xt = Xi((k-1)*nbin+1:(k)*nbin);
        XXt = (LE*Xt')';
        Xtemp = [Xtemp XXt];
    end
    
    % neg transpose
    for j = 1:5
        TXi = [];
        for k = 1:nseg % transpose for all nseg sections
            Xt = Xtemp((k-1)*nsbin+1:(k)*nsbin);
            padlen = j*3;
            pad = zeros(1,padlen);
            TXt = [Xt(1+padlen:end) pad];
            TXi = [TXi (PLE*TXt')'];
        end
        trainingDataX11(idx,:) = TXi; % use pinv(LE) to go back
        nynum = chTranspose(ynum, -j);
        [~,nyi] = ismember(nynum,chordnums);
        trainingDatay11(idx,:) = nyi;
        idx = idx + 1;
    end
    
    % pos transpose
    for j = 1:6
        TXi = [];
        for k = 1:nseg
            Xt = Xtemp((k-1)*nsbin+1:(k)*nsbin);
            padlen = j*3;
            pad = zeros(1,padlen);
            TXt = [pad Xt(1:end-padlen)];
            TXi = [TXi (PLE*TXt')'];
        end
        trainingDataX11(idx,:) = TXi;
        nynum = chTranspose(ynum, j);
        [~,nyi] = ismember(nynum,chordnums);
        trainingDatay11(idx) = nyi;
        idx = idx + 1;
    end
end

% set label 0 to label length(chordnames)+1
trainingDatay(trainingDatay == 0) = length(chordnames)+1;
trainingDatay11(trainingDatay11 == 0) = length(chordnames)+1;

% save all the training data set collected
display('saving results......');
save(savename,'trainingDataX1','trainingDatay',...
    'trainingDataX11', 'trainingDatay11','-v7.3');

display('done......');
