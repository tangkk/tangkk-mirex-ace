% this is -ns
X = trainingDataX11;
y = trainingDatay11;
save('data/ns/CJKUR6seg-ns-full.mat','X','y','-v7.3');
% 
% % this is -ch
X = trainingDataX22;
y = trainingDatay22;
save('data/ch/CJKUR6seg-ch-full.mat','X','y','-v7.3');