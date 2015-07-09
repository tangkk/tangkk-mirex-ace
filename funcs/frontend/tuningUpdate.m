% interpolate the original S at every x position throughout
% nslices*ntones, the edge values are just interpolated as zeros
%
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
function S = tuningUpdate(S,et)

st = 440;
p = (log(et / st) / log(2)) * 36;

nslices = size(S,2);
ntones = size(S,1);

for j = 1:nslices
    % insert two zeros on both side to serve the possible p = +/- 1.5
    % thus the orginal index x = [-1,0,1,2,...,ntones, ntones + 1, ntones + 2];
    % and interpolation index xi = 1:ntones + p;
%     y = [0;0;S(:,j);0;0];
%     x = (-1:ntones+2)';
    y = S(:,j);
    x = (1:ntones)';
    xi = (1:ntones)' + p;
    yi = interp1(x,y,xi,'linear','extrap');
    S(:,j) = yi;
end