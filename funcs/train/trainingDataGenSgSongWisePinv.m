% Generate training data based on the ground truth files
% this process leverages the frontend and the ground truth data

% in spectrogram level
function trainingDataGenSgSongWisePinv(savename, gtList, noinv, no7)

[feparam, ~, ~, ~, ~] = paramInit10();
chordmode =  chordTypesGen;
fe = fopen(gtList,'r');
tline = fgetl(fe);

% the size of the training data is unknown yet.
% and since each training case does not necessary have the same length
% we use cell to store them
% note that we still use vector to store targets (labels)
trainingDataX1 = {};
trainingDatay = {};

if noinv 
    load chordnames-noinv.mat;
elseif no7
    load chordnames-no7.mat;
else
    load chordnames-inv.mat;
end

chordnums = chnames2chnums(chordnames, chordmode);

while ischar(tline)
    trainingDataOneSongX1 = [];
    trainingDataOneSongy = [];
    
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
    Strain1 = X;
    nslices = size(X,2);
    bdrys = 1:nslices;
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
        nch = castGtLabel(ch,noinv,no7);
        chnum = chname2chnum(nch, chordmode);
        [~,tlabel] = ismember(chnum,chordnums);
        
        % grab data and make training point -
        % 3. store the ground truth label in tlabel
        % tlabel 0 is for "N" chord, follow the below code if want to know
        % why
        tcase1 = Strain1(:,sb:eb);
        tcasey = ones(1,eb-sb+1) * tlabel;
        
        % store each segment (possibly of different length) into cells
        trainingDataOneSongX1 = [trainingDataOneSongX1;tcase1'];
        trainingDataOneSongy = [trainingDataOneSongy;tcasey'];
        
        gline = fgetl(fg);
    end
    fclose(fg);
    tline = fgetl(fe);
    % stack over per song training datas
    % set label 0 to label length(chordnames)+1
%     trainingDataOneSongy(trainingDataOneSongy == 0) = length(chordnames)+1;
    trainingDataX1 = [trainingDataX1;trainingDataOneSongX1];
    trainingDatay = [trainingDatay;trainingDataOneSongy];
end


% note that after the below process each entry of X will be flattened into one dim

% generate other training data for all 12 keys for every training data
% entry in X1 (nbin dim feature - note salience)
display('collecting training data for all 12 keys......');

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

trainingDataX11 = {};
trainingDatay11 = {};
nsongs = size(trainingDataX1,1);
for ii = 1:nsongs
    display(ii);
    trainingDataOneSongX1 = trainingDataX1{ii};
    trainingDataOneSongy = trainingDatay{ii};
    
    len = size(trainingDataOneSongX1,1);
    trainingDataOneSongX11 = zeros(12,size(trainingDataOneSongX1,1),size(trainingDataOneSongX1,2));
    trainingDataOneSongy11 = zeros(12,size(trainingDataOneSongy,1),size(trainingDataOneSongy,2));
    idx=1;
    for i = 1:len
        
        Xi = trainingDataOneSongX1(i,:);
        yi = trainingDataOneSongy(i);
        if yi ~= 0
            ynum = chordnums{yi};
        else
            ynum = '0:0';
        end
        
        % FIXME: how to do the non-linear circshift?
        % neg transpose
        nseg = 1;
        
        Xtemp = (LE*Xi')';
        
        for j = 0:5
            TXi = [];
            for k = 1:nseg % transpose for all nseg sections
                Xt = Xtemp((k-1)*nsbin+1:(k)*nsbin);
                padlen = j*3;
                pad = zeros(1,padlen);
                TXt = [Xt(1+padlen:end) pad];
                TXi = [TXi (PLE*TXt')'];
            end
            trainingDataOneSongX11(12-j,idx,:) = TXi;
            nynum = chTranspose(ynum, -j);
            [~,nyi] = ismember(nynum,chordnums);
            trainingDataOneSongy11(12-j,idx,:) = nyi;
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
            trainingDataOneSongX11(j,idx,:) = TXi;
            nynum = chTranspose(ynum, j);
            [~,nyi] = ismember(nynum,chordnums);
            trainingDataOneSongy11(j,idx,:) = nyi;
        end
        idx = idx + 1;
    end
    
    trainingDataOneSongy11(trainingDataOneSongy11 == 0) = length(chordnames)+1;
    trainingDataX11 = [trainingDataX11 trainingDataOneSongX11];
    trainingDatay11 = [trainingDatay11 trainingDataOneSongy11];

end

% save all the training data set collected
display('saving results......');
save(savename,'trainingDataX1','trainingDatay',...
    'trainingDataX11', 'trainingDatay11','-v7.3');

display('done......');
