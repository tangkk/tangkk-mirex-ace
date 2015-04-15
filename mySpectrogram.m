% implement a size 4096 hamming windowed, hop size 512 STFT spectrogram
% with sample rate 11025, each hop's duration is 0.0464s = 46.4399ms
function X = mySpectrogram(x, wl, hopsize)

len = length(x);
w = hamming(wl);
lenSlice = ceil((length(x)-wl)/hopsize);
X = zeros(wl/2, lenSlice);
xrms = zeros(1,lenSlice);
idx = 1;
for i = wl/2+1:hopsize:len - wl/2
    raws = i-wl/2;
    rawe = i+wl/2-1;
    raw = x(raws:rawe).*w;
    xrms(idx) = rms(x(raws:rawe));
    fftraw = fft(raw);
    X(:,idx) = 2*abs(fftraw(1:wl/2));
    if max(X(:,idx)) > 0
        X(:,idx) = X(:,idx) / max(X(:,idx));
    end
    idx = idx + 1;
end

% perform a low cut
rmst = 0.05;
xcut = xrms;
xcut(xcut > rmst) = 1;
xcut(xcut <= rmst) = 0;
vc = find(xcut == 0);
X(:,vc) = zeros(wl/2, length(find(vc)));