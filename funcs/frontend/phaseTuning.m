% tuning based on phase information
% assuming nsemitones = 3

function [S, et] = phaseTuning(S)

nslices = size(S,2);
ntones = size(S,1);

Sbar = sum(S,2) ./ nslices; % make the lenght of Sbar divisable by 3?
dftSbar = fft(Sbar);

tp = length(dftSbar) * (1/3) + 1;
phiSbar = angle(dftSbar);

phi = interp1q(1:length(phiSbar),phiSbar,tp);

delta = wrapd(- phi - 2*pi/3) / (2*pi);

st = 440;
et = st*2^(delta/12);

% then we interpolate the original S at every x position throughout
% nslices*ntones, the edge values are just interpolated as zeros
S = tuningUpdate(S,et);
