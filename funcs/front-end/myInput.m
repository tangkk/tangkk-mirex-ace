function [x, fs] = myInput(path, usemono, range, isexamine)

info = audioinfo(path);
fs = info.SampleRate;
if isexamine == 1 % examine range
    rstart = round(range(1)*fs)+1;
    rend = round(range(2)*fs)+1;
    [x,~] = audioread(path,[rstart,rend]);
else
    [x,~] = audioread(path);
end
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
