function S = standardization(S, wl, enSTD, df)

nslices = size(S,2);
ntones = size(S,1);
mu = zeros(size(S));
sigma = zeros(size(S));
len = 2^nextpow2(ntones);
winh = hamming(2*wl);
win = [winh./norm(winh,1);zeros(len - 2*wl,1)];
fftwin = fft(win);

comp = wl;
for j = 1:nslices
    % compute running mean
    col = S(:,j);
    col = [col;zeros(len - length(col),1)];
    fftcol = fft(col);
    conv = ifft(fftwin.*fftcol);
    conv(conv < 0) = 0;
    muj = conv(1+comp:min(ntones+comp,length(win)));
    muj = [muj ; muj(end) .* ones(ntones+comp-length(win),1)];
    mu(:,j) = muj;
    
    % compute running std
    scol = (S(:,j) - mu(:,j)).^2;
    scol = [scol;zeros(len - length(scol),1)];
    fftscol = fft(scol);
    sconv = ifft(fftwin.*fftscol);
    sconv(sconv < 0) = 0;
    sigmaj = sqrt(sconv(1+comp:min(ntones+comp,length(win))));
    sigmaj = [sigmaj ; sigmaj(end) .* ones(ntones+comp-length(win),1)];
    sigma(:,j) = sigmaj;
end

% SUB
S = S - mu; S(S<0) = 0; % Y(k,m) - mu(k,m);

% STD
if enSTD
stemp = sort(sigma(:));
minsigma = stemp(find(stemp > 0,1,'first'));
sigma(sigma == 0) = minsigma;
S = S./sigma; % (Y(k,m) - mu(k,m)) / sigma(k,m);
end

% S = S ./ max(max(S));
S = normalizeGram(S);

if df
myImagePlot(mu, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'mu of simple tone salience matrix');
myImagePlot(sigma, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'sigma of simple tone salience matrix');
end
