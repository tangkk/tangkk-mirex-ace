% read the ground truth tuning from local folder
function [S, et] = gtTuning(S, tunpath)

ftun = fopen(tunpath,'r');
tline = fgetl(ftun);
fclose(ftun);

st = 440;
et = str2double(tline);

% now modify S based on the new tuning of the song, so that
% the middle bin of each semitone corresponds to the semitone frequency in
% the estimated tuning
% let's treat the problem in this way:
% st = standard tuning = 440Hz
% et = estimated tuning
% now we wonder what's the position of the et related to st in the axis of
% 3 semitones per bin in terms of bin
% so we have st * (2 ^ (p / 36)) = et;
% so p = (log(et / st) / log(2)) * 36;

p = (log(et / st) / log(2)) * 36;

% then we interpolate the original S at every x position throughout
% nslices*ntones, the edge values are just interpolated as zeros

S = tuningUpdate(S,p);

