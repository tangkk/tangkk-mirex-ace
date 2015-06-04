function acf = ftacf(x)


x = x(:);

[M,N] = size(x);

X = fft(x,2^nextpow2(2*M-1));
acf = ifft(X.*conj(X));

acf = acf(1:M)./[M:-1:1]';
