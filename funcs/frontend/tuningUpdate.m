% interpolate the original S at every x position throughout
% nslices*ntones, the edge values are just interpolated as zeros
function S = tuningUpdate(S,p)

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