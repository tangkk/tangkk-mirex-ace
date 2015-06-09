function [S, et] = vampTuning(S, vamptunpath)

ftun = fopen(vamptunpath,'r');
tline = fgetl(ftun);
fclose(ftun);

% process the tline to get the tuning data
tokens = strsplit(tline,'\t');
st = 440; % 440Hz standard tuning
et = str2double(tokens{3});

nslices = size(S,2);
ntones = size(S,1);

p = (log(et / st) / log(2)) * 36;

% then we interpolate the original S at every x position throughout
% nslices*ntones, the edge values are just interpolated as zeros

for j = 1:nslices
    % insert two zeros on both side to serve the possible p = +/- 1.5
    % thus the orginal index x = [-1,0,1,2,...,ntones, ntones + 1, ntones + 2];
    % and interpolation index xi = 1:ntones + p;
    Y = [0;0;S(:,j);0;0];
    x = (-1:ntones+2)';
    xi = (1:ntones)' + p;
    yi = interp1q(x,Y,xi);
    S(:,j) = yi;
end