function S = standardization(S, lenKernel, enSTD, specWTN, df)

nslices = size(S,2);
ntones = size(S,1);
mu = zeros(size(S));
sigma = zeros(size(S));
len = ntones;
winh = hamming(lenKernel);
win = [winh./norm(winh,1);zeros(len - lenKernel,1)];
fftwin = fft(win);

% Special Convolution
% special convolution is as long as the convolvee, i.e. the first argument.
% in the valid core part of the convolution it contains the usual convolution
% values, but the pads at the beginning (ending) have the same values
% as the first (last) valid convolution bin.
assert(mod(lenKernel,2) == 0, 'lenKernel invalid!');
pad = lenKernel/2;
for j = 1:nslices
    % compute running mean
    col = S(:,j);
    fftcol = fft(col);
    conv = ifft(fftwin.*fftcol);
    conv(conv < 0) = 0;
    conv = abs(conv);
    muj = [ones(pad,1)*conv(1+lenKernel);...
        conv(1+lenKernel:ntones);...
        ones(pad,1)*conv(ntones)];
    mu(:,j) = muj;
    
    % compute running std
    scol = (S(:,j) - mu(:,j)).^2;
    fftscol = fft(scol);
    sconv = ifft(fftwin.*fftscol);
    sconv(sconv < 0) = 0;
    sconv = abs(sconv);
    sconv = sqrt(sconv);
    sigmaj = [ones(pad,1)*sconv(1+lenKernel);...
        sconv(1+lenKernel:ntones);...
        ones(pad,1)*sconv(ntones)];
    sigma(:,j) = sigmaj;
end

if enSTD
    % (Y(k,m) - mu(k,m)) / sigma(k,m);
    Sp = S(sigma > 0);
    mup = mu(sigma > 0);
    sigmap = sigma(sigma > 0);
    Sp = Sp - mup;
    Sp(Sp < 0) = 0;
    Sp = Sp./(sigmap.^specWTN);
    S(sigma > 0) = Sp;
else
    % Y(k,m) - mu(k,m);
    S = S - mu; S(S<0) = 0;
end

if df
myImagePlot(mu, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'mu of simple tone salience matrix');
myImagePlot(sigma, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'sigma of simple tone salience matrix');
end
