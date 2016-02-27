function [sg, endtime] = sgfrontEndDecode(audiopath, feparam, df, enPlot)

display('input in progress...');
x = myInput(audiopath, feparam.stereotomono, feparam.fs);

display('computing spectrogram...');
X = mySpectrogram(x, feparam.wl, feparam.hopsize);

endtime = (1/feparam.fs)*length(x);
sg = X;



