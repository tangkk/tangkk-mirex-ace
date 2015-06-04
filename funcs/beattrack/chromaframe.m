function [spec] = chromaframe(x,spark);
%  function [spec,mfcc,cq,hpcp,chroma] = chromaframe(x,spark);

% function to return spectrogram, constq, hpcp and chromagram
% for one single frame of arbitrary length
% with the possible inclusion of an adaptive thresholding stage.

fmin = 110; 
fmax = 880;

if nargin<2
    spark = sparsekernel(fmin, fmax, 36, 44100/16, 0.054);
    spark(1025:end,:) = [];
end


% make x a row vector
x = x(:)';
x2 = x;
fs = 44100;
% downsample by a factor of 16.
%x = x(1:16:end);
% x = resample(x,11025,44100);
 x = resample(x,2756,11024);
%  x = resample(x,11024,44096);

len = length(x);


% make windowing function
w = hanningz(len);
w = w(:)';
%  w = ones(1,length(x)); % or no windowing... shouldn't be better..
% take fft
spec = abs(fft(w.*x,2048));
spec = adapt_thresh(spec(1:1024),16,15);

%  %spec = spec(1:1024);
%  
%  %cq = adapt_thresh(abs(spec*spark));   
%  cq = abs(spec*spark);
%  hpcp = zeros(1,36);
%  
%  for k=1:36 
%      hpcp(k) =  sum(abs(cq(k:36:end)));
%  end
%  
%  %hpcp = adapt_thresh(hpcp,2,3);
%  
%  % for k=1:round(abs(log2(fmax/fmin))),
%  %     l(k) = sum(hpcp(k:3:end));
%  % end
%  % 
%  % [val,ind] = max(l);
%  % 
%  % chroma = hpcp(ind:3:end);
%  % 
%  for i=1:12 % sum bins.. 
%      chroma(i) = sum(hpcp((i-1)*3+1:3*i));
%  end


%chroma = adapt_thresh(chroma,3,2);

%  % modulated complex lapped transform
%  % spec = abs(fmclt(x',1024)');
%  % spec = adapt_thresh(spec);
%  
%  % % try to treat everything as gaussians
%  % n = 1:length(cq);
%  % mu = sum(n.*cq)/sum(cq);
%  % sigma = sqrt(sum((n-mu).^2)/sum(cq));
%  % cq = exp(-0.5 * ((n - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
%  % 
%  % n = 1:length(hpcp);
%  % mu = sum(n.*hpcp)/sum(hpcp);
%  % sigma = sqrt(sum((n-mu).^2)/sum(hpcp));
%  % hpcp = exp(-0.5 * ((n - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
%  % 
%  % n = 1:length(chroma);
%  % mu = sum(n.*chroma)/sum(chroma);
%  % sigma = sqrt(sum((n-mu).^2)/sum(chroma));
%  % chroma = exp(-0.5 * ((n - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
%  % 
%  % n = 1:length(spec);
%  % mu = sum(n.*spec)/sum(spec);
%  % sigma = sqrt(sum((n-mu).^2)/sum(spec));
%  % spec = exp(-0.5 * ((n - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
%  
%  %x2 = resample(x2,8000,44100);
%  %spec = mfcc(x',8000,100);
%  %spec = abs(sum(spec'))';
%  
% x2 = x2(1:4:end);
% spec2 = abs(fft(hanning(length(x2))'.*x2,2048));
% spec2 = spec2(1:1024);
%  mlmx = fft2melmx(1024,round(44100/16),40);
% [size(mlmx) size(spec2)];
%  mfcc = 20*log10(1+spec*mlmx');
%  spec = 20*log10(1+spec*mlmx');

%  spec = adapt_thresh(mfcc,2,3);
%  x2 = resample(x2,1378,44096);
%  len = length(x2);
%  w = hanningz(len);
%  w = w(:)';
%  % take fft
%  spec = abs(fft(w.*x2,1024));
%  spec = adapt_thresh(spec(1:512),16,15);
  spec = spec(1:512);
%  mlmx = fft2melmx(512,round(44100),40);
%  spec = spec*mlmx';