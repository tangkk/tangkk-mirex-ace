function [audiofolder, audiopath, cpfolder, cppath, gtfolder, gtpath] = inputDecode(tline, codec)

songpath = tline;
pathtokens = strsplit(songpath,'/');
artist = pathtokens{1};
album = pathtokens{2};
songtitle = pathtokens{3};

audioroot = './audio/';
audiofolder = strcat(audioroot, artist, '/', album);
audiopath = [audiofolder '/' songtitle '.' codec];

cproot = './cp/';
cpfolder = strcat(cproot, artist, '/', album);
cppath = [cpfolder '/' songtitle '.txt'];

gtroot = './gt/';
gtfolder = strcat(gtroot, artist, '/', album);
gtpath = [gtfolder '/' songtitle '.lab'];