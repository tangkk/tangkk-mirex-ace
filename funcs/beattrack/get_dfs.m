function df = get_dfs(x,p)

% function to calculate the following onset detection functions
% df{1} = complex spectral difference
% df{2} = spectral difference
% df{3} = phase deviation
x = mean(x,2);

% onset analysis step increment
o_step = p.winlen*2; % should be 1024
% onset analysis winlen
o_winlen = o_step*2; % should be 2048

hlfwin = o_winlen/2; % will be half fft size

% formulate hanningz window function
win = hanningz(o_winlen);
%  win = tukeywin(o_winlen,0.5);

% loop parameters
N = length(x);
pin = 0;
pend = N - o_winlen;

% vectors to store phase and magnitude calculations
theta1 = zeros(hlfwin,1);
theta2 = zeros(hlfwin,1);
oldmag = zeros(hlfwin,1);

% output onset detection functions
df = {};

% df sample number
k = 0;
while pin<pend
    
    k=k+1;
    % calculate windowed fft frame
    segment = x(pin+1:pin+o_winlen);
    X = fft(fftshift(win.*segment));
    %X = X.*fftshift(hanningz(length(X)));
    X = X(floor(length(X)/2)+1:length(X),:);
  %  X = X.*[length(X):-1:1]';
    % separate into magnitude
    mag = (abs(X));
	
%  	mag = [0 abs(diff(log(eps+mag)))']';
    % and phase
    theta = angle(X);
    
    % complexsd part
        dev=princarg(theta-2*theta1+theta2);
%  		keyboard
        meas=oldmag - (mag.*exp(i.*dev));
        df{1}(k) = sum(sqrt((real(meas)).^2+(imag(meas)).^2));
        
%      % spectral difference part    
%          dev2=sqrt(mag.^2-oldmag.^2);
%          df{2}(k) = sum(abs(dev2(mag>0.1)));
%      
%      
%      % phase deviation part
%          df{3}(k) = sum(abs(dev((mag>0.1))));
%  %        df{3}(k) = sum(abs(dev(end-5:end)));
%          
%      % energy part
%          df{4}(k) = sum(abs(segment));
%          
%      % hfc part    
%          df{5}(k) = sum(mag.*(length(mag):-1:1)');
%      %    df{5}(k) = sum(mag.*rand(hlfwin,1));
%          
    % update vectors
    theta2 = theta1;
    theta1 = theta;
    oldmag = mag;
    pin = pin+o_step;
end

% now interpolate each detection function by a factor of 2,
% to get resolution of 11.6ms

for j=1:1,%5
    df{j} = interp(df{j},2);
    % also check there are no negative elements
    df{j}(df{j}<0) = 0;
    % and scale to sum to unity
%    df{j} = (df{j}+eps)/sum(df{j}+eps);
end

