function [S, et] = vampTuning(S, vamptunpath)

ftun = fopen(vamptunpath,'r');
tline = fgetl(ftun);
fclose(ftun);

% process the tline to get the tuning data
tokens = strsplit(tline,'\t');
et = str2double(tokens{3});

% then we interpolate the original S at every x position throughout
% nslices*ntones, the edge values are just interpolated as zeros
S = tuningUpdate(S,et);