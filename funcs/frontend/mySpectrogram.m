% implement a size 4096 hamming windowed, hop size 512 STFT spectrogram
% with sample rate 11025, each hop's duration is 0.0464s = 46.4399ms
function X = mySpectrogram(x, wl, hopsize)

len = length(x);
w = hamming(wl);
nslices = ceil((length(x)-wl)/hopsize);
X = zeros(wl/2+1, nslices);
idx = 1;
for i = wl/2+1:hopsize:len - wl/2
    raws = i-wl/2;
    rawe = i+wl/2-1;
    raw = x(raws:rawe).*w;
    fftraw = abs(fft(raw));
    if max(fftraw) < 2 % low cut
        fftraw(:) = 0;
    end
    X(:,idx) = 2*fftraw(1:wl/2+1);
    idx = idx + 1;
end