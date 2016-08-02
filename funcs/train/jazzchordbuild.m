% Generate training data based on the ground truth files
% this process leverages the frontend and the ground truth data

gtList = 'JazzTutorial271List.txt';

fe = fopen(gtList,'r');
tline = fgetl(fe);

keynames = {'A', 'E', 'B', 'F#', 'C#', 'G#', 'D#', 'Bb', 'F', 'C', 'G', 'D'};

J = {};
JN = {};
JJ = {};

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
    
    % there is a training data point at every ground truth line
    fg = fopen(gtpath,'r');
    gline = fgetl(fg);
    
    while ischar(gline)
        % decipher start time, end time and chord
        strtoks = strsplit(gline,' ');

        ch = strtoks{3};
        
        if ~strcmp(ch,'N')
            strtoks = strsplit(ch,':');
            nch = strtoks{2};
        else
            nch = ch;
        end
        
        if sum(ismember(J,nch)) == 0
            J = [J nch];
            if ~strcmp(ch,'N')
                JN = [JN nch];
                for i = 1:12
                    key = keynames{i};
                    nnch = [key ':' nch];
                    JJ = [JJ nnch];
                end
            end
        end
        
        gline = fgetl(fg);
    end
    fclose(fg);
    tline = fgetl(fe);
end

chordnames = JJ';
chordmode = JN';

save('chordnames-jazz-all.mat','chordnames');
save('chordmode-jazz-all.mat','chordmode');
save('keynames.mat','keynames');

