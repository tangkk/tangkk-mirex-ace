% read the ground truth tuning from local folder
function [S, et] = gtTuning(S, tunpath)

ftun = fopen(tunpath,'r');
tline = fgetl(ftun);
fclose(ftun);

et = str2double(tline);

% then we interpolate the original S at every x position throughout
% nslices*ntones, the edge values are just interpolated as zeros
S = tuningUpdate(S,et);

