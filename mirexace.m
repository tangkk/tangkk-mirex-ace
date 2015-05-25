% Automatic Chord Estimation
% A ''bass centric + gestalt'' approach

% ********************************************************** %
% ********************* Batch Input ************************ %
% ********************************************************** %
warning off;
installbnt;
path(path,genpath(fullfile('./funcs')));
warning on;
close all;
clear;
clc;

% ********************************************************** %
% ********************* Control Panel ********************** %
% ********************************************************** %
% input control
stereotomono = false;
codec = 'mp3';
% output control
isexamine = 1; % 0: full evaluation, 1: examine piece
enEval = 1;
% plot control
df = isexamine;
enPlotFE = 0;
enPlotME = 1;
enPlotBE = 1;
enPlotFB = 1;
enPlotTS = 0;
% gestalt control
enGesComp = true;
enGesRed = true;
wgmax = 10; 
% chored grain size control
grainsize = 1;
% chord vocabulary control (normalized according to # of notes)
tetradcontrol = 1 / 3;
pentacontrol = 1 / 4;
hexacontrol = 1 / 5;
inversioncontrol = 1 / 3;
enDyad = 0;
enMajMin = 1;
enSusAdd = 1;
enSixth = 1;
enSeventh = 1;
enExtended = 1;
enAugDim = 1;
enMajMinBass = 1;
enSeventhBass = 1;
enOtherSlash = 0;
% chord casting control
enCast2MajMin = 1; % in case we'd like to substitute others to maj or min
% feedback control (how many times)
fbn = 2;

% ********************************************************** %
% ********************* Setup ****************************** %
% ********************************************************** %
chordmode = buildChordMode(tetradcontrol, pentacontrol, hexacontrol, inversioncontrol,...
    enDyad, enMajMin, enSusAdd,...
    enSixth, enSeventh, enExtended, enAugDim,...
    enMajMinBass, enSeventhBass, enOtherSlash);
bnet = dbnSetup(chordmode);


% ********************************************************** %
% ****************** Batch Process ************************* %
% ********************************************************** %
feval = fopen('evallist.txt','r');
tline = fgetl(feval);
while ischar(tline)
    
% ********************************************************** %
% ********************* Input ****************************** %
% ********************************************************** %

% input stage
display('input...');

[audiofolder, audiopath, cpfolder, cppath, gtfolder, gtpath] = inputDecode(tline, codec);

% ********************************************************** %
% ********************* Front End ************************** %
% ********************************************************** %
display('frontend...');

[fs, hopsize, nslices, endtime, S] = frontEndDecode(audiopath, stereotomono, df, enPlotFE);

% ********************************************************** %
% ********************* Mid End **************************** %
% ********************************************************** %

[So, Sb, Shc, basegram, uppergram] = midEndDecode(S, wgmax, df, enGesComp, enGesRed, enPlotME);

% ********************************************************** %
% ********************* Back End *************************** %
% ********************************************************** %
display('backend...');
bdrys = Shc;

[rootgram, bassgram, treblegram, bdrys] = backEndDecode(bnet, chordmode,...
    basegram, uppergram, bdrys, grainsize, enCast2MajMin, nslices, df, enPlotBE);

% % ********************************************************** %
% % ********************* Feedback *************************** %
% % ********************************************************** %
for i = 1:1:fbn
display(['re-midend...' num2str(i)]);
[basegram, uppergram] = updateBaseUpperGram(bdrys, S, So, 1, 0.25);

display(['re-backend...' num2str(i)]);
[rootgram, bassgram, treblegram, bdrys] = backEndDecode(bnet, chordmode,...
    basegram, uppergram, bdrys, grainsize, enCast2MajMin, nslices, df, enPlotFB);
end

% ********************************************************** %
% ***************** Tonic Computation ********************** %
% ********************************************************** %
[scaleSeq, tonicSeq] = tonicDecode(bassgram, treblegram, bdrys, chordmode,...
    df, enPlotTS);

% ********************************************************** %
% ********************* Output ***************************** %
% ********************************************************** %

if isexamine
    display(strcat('end of analyzing...',audiopath));
    break;
else
    display('output...');
    writeChordProgression(cpfolder, cppath, nslices, hopsize, fs,...
        rootgram, treblegram, bdrys, endtime, chordmode);
    display(strcat('end of analyzing...',audiopath));
    tline = fgetl(feval);
end

end % pair with the very first while loop

fclose(feval);

% ********************************************************** %
% ********************* Evaluation ************************* %
% ********************************************************** %
if enEval && ~isexamine
    display('evaluation...');
    evaluate;
end

% ********************************************************** %
% ********************* Playback *************************** %
% ********************************************************** %
% if isexamine
%     display('playback...');
%     p = audioplayer(x,fs);
%     play(p);
% end