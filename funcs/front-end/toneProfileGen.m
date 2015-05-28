% build the tone profiles for calculating note salience matrix
% each sinusoidal at frequency 'ftone' is generated via sin(2*pi*n*f/fs)
% the true frequency of the tone is supposed to lie on bin notenum*numsemitones-1,
% e.g. A4 is bin 49*numsemitones-1 = 146, C4 is bin 40*numsemitones-1 = 119 (note that notenum is
% not midinum, note num is the index of the key on an 88 key piano with A0 = 1)
% therefore notenum = (binnum+1) / numsemitones if the tuning is correct.
function [Ms,Mc] = toneProfileGen(s, wl, numtones, numsemitones, fmin, fmax, fratio, fs)

w = hamming(wl);
Ms = zeros(numtones, wl/2); % simple tone profiles
Mc = zeros(numtones, wl/2); % complex tone profiles
for toneidx = 1:1:numtones
    ftone = fmin*(fratio^(toneidx-2));
    stone = sin(2*pi*(1:wl)*ftone/fs).*w';
    ctone = (s^0*sin(2*pi*(1:wl)*ftone/fs) + s^1*sin(2*pi*(1:wl)*2*ftone/fs) + ...
        s^2*sin(2*pi*(1:wl)*3*ftone/fs) + s^3*sin(2*pi*(1:wl)*4*ftone/fs)).*w';
    
    ffttone = abs(fft(stone));
    ffttone = ffttone(1:wl/2);
    ffttone = ffttone / norm(ffttone,2);
    
    fftctone = abs(fft(ctone));
    fftctone = fftctone(1:wl/2);
    fftctone = fftctone / norm(fftctone,2);

    Ms(toneidx,:) = ffttone;
    Mc(toneidx,:) = fftctone;
end