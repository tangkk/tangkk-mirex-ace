% Generate training data based on the ground truth files
% this process leverages the frontend and the ground truth data

function gtendtimeset = getGtEndTimes(gtList)

fe = fopen(gtList,'r');
tline = fgetl(fe);
gtendtimeset = zeros(1,1);
tidx = 1;
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
    
    display(['collecting training data of ' songtitle ' ......']);

    fg = fopen(gtpath,'r');
    gline = fgetl(fg);
    
    while ischar(gline)
        oldgline = gline;
        gline = fgetl(fg);
    end
    fclose(fg);
    
    strtoks = strsplit(oldgline,'\t');
    if length(strtoks) == 1
        strtoks = strsplit(oldgline,' ');
    end
    endtime = strtoks{2};
    gtendtimeset(tidx) = str2double(endtime);
    tidx = tidx + 1;
    tline = fgetl(fe);
end


fclose(fe);