function x = istft2(d, ftsize, w, h)
% X = istft(D, F, W, H)                   Inverse short-time Fourier transform.
%	Performs overlap-add resynthesis from the short-time Fourier transform 
%	data in D.  Each column of D is taken as the result of an F-point 
%	fft; each successive frame was offset by H points. Data is 
%	hamm-windowed at W pts..
% dpwe 1994may24.  Uses built-in 'ifft' etc.
% $Header: /homes/dpwe/public_html/resources/matlab/RCS/istft.m,v 1.1 2002/02/13 16:16:12 dpwe Exp $

s = size(d);
%if s(1) != (ftsize/2)+1
%  error('number of rows should be fftsize/2+1')
%end
 
cols = s(2);
xlen = ftsize + cols * (h);
x = zeros(1,xlen);

if rem(w, 2) == 0   % force window to be odd-len
  w = w + 1;
end

win = zeros(1, ftsize);

halff = ftsize/2;   % midpoint of win
halflen = (w-1)/2;
acthalflen = min(halff, halflen);

halfwin = 0.5 * ( 1 + cos( pi * (0:halflen)/halflen));
win((halff+1):(halff+acthalflen)) = halfwin(1:acthalflen);
win((halff+1):-1:(halff-acthalflen+2)) = halfwin(1:acthalflen);

for b = 0:h:(h*(cols-1))
  ft = d(:,1+b/h)';
  ft = [ft, conj(ft([((ftsize/2)):-1:2]))];
  px = real(ifft(ft));
  x((b+1):(b+ftsize)) = x((b+1):(b+ftsize))+[px 0].*win;
end

x = x';