function S = standardization(S, wl)

nslices = size(S,2);
ntones = size(S,1);
mu = zeros(size(S));
sigma = zeros(size(S));
len = 2^nextpow2(ntones);
win = [ones(2*wl,1)./(2*wl);zeros(len - 2*wl,1)];
fftwin = fft(win);

comp = wl;
for j = 1:nslices
    % compute running mean
    col = S(:,j);
    col = [col;zeros(len - length(col),1)];
    fftcol = fft(col);
    conv = ifft(fftwin.*fftcol);
    conv(conv < 0) = 0;
    mu(:,j) = conv(1+comp:ntones+comp);
    
    % compute running std
    scol = (S(:,j) - mu(:,j)).^2;
    scol = [scol;zeros(len - length(scol),1)];
    fftscol = fft(scol);
    sconv = ifft(fftwin.*fftscol);
    sconv(sconv < 0) = 0;
    sigma(:,j) = sqrt(sconv(1+comp:ntones+comp));
end

S = S - mu; S(S<0) = 0; % Y(k,m) - mu(k,m);
S = S.*sigma; % (Y(k,m) - mu(k,m)) / sigma(k,m);

S = S ./ max(max(S));

% myImagePlot(mu, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'mu of simple tone salience matrix');
% myImagePlot(sigma, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'sigma of simple tone salience matrix');
% myImagePlot(S, 1:nslices, 1:ntones, 'slice', '1/3 semitone', 'standardize simple tone salience matrix');
