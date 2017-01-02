% this is -ns
X = trainingDataX11;
y = trainingDatay11;
save('data/ns/CJKURB6seg-ns-inv.mat','X','y','-v7.3');
% 
% % this is -ch
X = trainingDataX22;
y = trainingDatay22;
save('data/ch/CJKURB6seg-ch-inv.mat','X','y');