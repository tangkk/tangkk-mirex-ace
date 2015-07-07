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

st = 440; % 440Hz standard tuning
et = st*2^(delta/12);

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
