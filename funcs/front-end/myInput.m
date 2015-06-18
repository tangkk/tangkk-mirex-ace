function x = myInput(path, usemono, fs)

[x,ofs] = audioread(path);
x = resample(x, fs, ofs);

if usemono
    x = (x(:,1)+x(:,2))/2;
else
    x = x(:,1);
end
songMax = max(abs(x));
x = x / songMax;
