% segment waves as STFT does
function X = waveseg(x, wl, hopsize)

len = length(x);
nslices = ceil((length(x)-wl)/hopsize);
X = zeros(wl/2, nslices);
idx = 1;
for i = wl/2+1:hopsize:len - wl/2
    raws = i-wl/2;
    rawe = i+wl/2-1;
    raw = x(raws:rawe)
    X(:,idx) = raw;
    idx = idx + 1;
end