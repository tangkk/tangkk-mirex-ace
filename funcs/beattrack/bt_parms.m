function p = bt_parms(res)

if nargin<1
    res = 0.01161;
end

p.fs = 44100;

p.timeres = round(p.fs * res);

p.winlen = round(512^2/p.timeres);

p.step = round(p.winlen/4);

p.bwinlen = 512; % always!
p.bstep = 128; % for the beat tracker!

% step and consistency thresholds from beat tracker
p.stepthresh = round(8*(512/p.timeres));
p.constthresh  = round(p.stepthresh/2);

% parameter for rayleigh distribution weighting
% p.rayparam = round(43*(512/p.timeres));
p.rayparam = round(33*(512/p.timeres));

% minimum and maximum periodicities for comb filterbank
p.pmax = round(80*(512/p.timeres));
p.pmin = round(4*(512/p.timeres));
p.lowest = round(21*(512/p.timeres)); % dixon upper limit of 247 bpm

%parameters for adaptive movingm mean threshold
p.pre = round(8*(512/p.timeres));
% p.post = round(7*(512/p.timeres));
p.post = p.pre-1;

% factor for converting between beat period and tempo
p.fact = 60*p.fs/p.timeres;

