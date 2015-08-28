function [audiopath, cppath] = inputDecode(tline)

songpath = tline;
pathtokens = strsplit(songpath,'/');
artist = pathtokens{1};
album = pathtokens{2};
songname = pathtokens{3};

audioroot = './audio/';
audiofolder = strcat(audioroot, artist, '/', album);
audiopath = [audiofolder '/' songname];

sufposes = strfind(songname,'.');
songtitle = songname(1:sufposes(end-1));
cproot = './cp/';
cpfolder = strcat(cproot, artist, '/', album);
cppath = [cpfolder '/' songtitle '.txt'];

% gtroot = './gt/';
% gtfolder = strcat(gtroot, artist, '/', album);
% gtpath = [gtfolder '/' songtitle '.lab'];
% 
% tunroot = './tuning/';
% tunfolder = strcat(tunroot, artist, '/', album);
% tunpath = [tunfolder '/' songtitle '.tun'];
% 
% vamptunroot = './vamp/tuning/';
% vamptunfolder = strcat(vamptunroot, artist, '/', album);
% vamptunpath = [vamptunfolder '/' songtitle '.lab'];