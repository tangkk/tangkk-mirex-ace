% this matrix can transform original linear space DFT (Hz bin) to log-freq
% space DFT (1/3 semitone bin) by means of cosine interpolations
% this process is implemented as described in M. Mauch's thesis
% first the original 2048-bin DFT is upsampled linearly 40 times
% then the upsampled spectrum is downsampled non-linearly with a constant-Q
function LE = logFreqNoteProfile(ntones, fmin, fratio, USR, fs, nbins)

df = fs / (nbins); % default is nbins
fi = (fs/2)*linspace(0,1,nbins);
ff = (fs/2)*linspace(0,1,nbins*USR);
dff = ff ./ 51.94; % df(f) = f/Q, where Q = 36 / ln2 = 51.94
fk = fmin*(fratio.^((1:ntones)-2));

% matrix to transform linear DFT to upsampled linear DFT
% size of the matrix is numbins * (USR*numbins)
% therefore by multiplying this matrix, a numbins DFT can be transformed to
% an upsampled USR*numbins bins
% every row of the matrix is the cosine interpolation of the correponding
% bin
h = zeros(nbins, USR * nbins);
for i = 1:nbins
    hf = zeros(1, USR*nbins);
    LB = find(ff > fi(i) - df, 1, 'first');
    RB = find(ff < fi(i) + df, 1, 'last');
    hf(LB:RB) = cos(2.*pi.*(ff(LB:RB) - fi(i)) ./ df) ./ 2 + 1/2;
    h(i,:) = hf;
end

% matrix to transform upsampled DFT to constant-Q DFT
% size of the matrix is (USR*numbins) * numtones
% by multiplying the matrix, a (USR*numbins) DFT can be transformed to a
% numtones bin
hl = zeros(USR*nbins, ntones);
for i = 1:USR*nbins
    hlf = zeros(1, ntones);
    LB = find(fk > ff(i) - dff(i), 1, 'first');
    RB = find(fk < ff(i) + dff(i), 1, 'last');
    hlf(LB:RB) = cos(2.*pi.*(ff(i) - fk(LB:RB)) ./ dff(i)) ./ 2 + 1/2;
    hl(i,:) = hlf;
end

% the final matrix is the product of the above two matrice,
% which will be a matrix of size numbins * numtones
% this matrix is a transformer to transform a vector of numbins into a
% vector of numtones, which equals to linear freq to log freq.
LE = (h * hl)';

% normalize this transformation matrix row wise (use L1 norm)
% FIXME: not sure whether this is reasonable under the constant-Q theory
for i = 1:ntones
    LE(i,:) = LE(i,:) ./ norm(LE(i,:),1);
end
