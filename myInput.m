function [x, fs] = myInput(path, usemono)

[x,fs] = audioread(path);
DSR = 4;
if usemono
    x = (x(:,1)+x(:,2))/2;
else
    x = x(:,1);
end
x = resample(x, 1, DSR);
fs = fs / DSR;
songMax = max(abs(x));
x = x / songMax;
