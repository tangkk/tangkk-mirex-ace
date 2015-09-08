% Generate a language model based on the ground truth files

function languageModelGen(savename, gtList)

[~, ~, ~, ~, chordmode] = paramInit10();
load chordnames.mat;
chordnums = chnames2chnums(chordnames, chordmode);
nchords = length(chordnums) + 1; % including the 'N' chord
LM = zeros(nchords,nchords);

fe = fopen(gtList,'r');
tline = fgetl(fe);
while ischar(tline)
    songpath = tline;
    pathtokens = strsplit(songpath,'/');
    artist = pathtokens{1};
    album = pathtokens{2};
    songname = pathtokens{3};
    
    sufposes = strfind(songname,'.');
    songtitle = songname(1:sufposes(end)-1);
    
    gtroot = './gt/';
    gtfolder = strcat(gtroot, artist, '/', album);
    gtpath = [gtfolder '/' songtitle '.lab'];
    
    display(['collecting language model data of ' songtitle ' ......']);
    
    % there is a training data point at every ground truth line
    fg = fopen(gtpath,'r');
    gline = fgetl(fg);
    % take two consecutive chords at a time
    while ischar(gline)
        strtoks = strsplit(gline,' ');
        st1 = str2double(strtoks{1});
        et1 = str2double(strtoks{2});
        ch1 = strtoks{3};
        nch1 = castGtLabel(ch1);
        chnum1 = chname2chnum(nch1, chordmode);
        
        gline = fgetl(fg);
        if ischar(gline)
            strtoks = strsplit(gline,' ');
            st2 = str2double(strtoks{1});
            et2 = str2double(strtoks{2});
            ch2 = strtoks{3};
            nch2 = castGtLabel(ch2);
            chnum2 = chname2chnum(nch2, chordmode);
            
            % FIXME: is it correct to just leave 'sus' chords to be cast to
            % 'maj/1' type?

            % create language model based on a ``SeventhsBass'' transition
            % matrix. iterate the pair for all 12 keys
            for i = 0:11
                tchnum1 = chTranspose(chnum1, i); % dim 1 entry for transition matrix
                tchnum2 = chTranspose(chnum2, i); % dim 2 entry for transition matrix
                [~,L1] = ismember(tchnum1,chordnums);
                [~,L2] = ismember(tchnum2,chordnums);
                if L1 == 0
                    L1 = nchords;
                end
                if L2 == 0
                    L2 = nchords;
                end
                LM(L1,L2) = LM(L1,L2) + 1;
            end
        end
    end
    fclose(fg);
    tline = fgetl(fe);
end

save(savename,'LM');
