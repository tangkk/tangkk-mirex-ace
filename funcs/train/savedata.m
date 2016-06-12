% this is -ns
X = trainingDataX11;
y = trainingDatay11;
save('data/ns/CJKU(191)12seg-ns-inv.mat','X','y','-v7.3');
% 
% % this is -ch
X = trainingDataX22;
y = trainingDatay22;
save('data/ch/CJKU(191)12seg-ch-inv.mat','X','y','-v7.3');

% this is -sg
% X = trainingDataX11;
% y = trainingDatay11;
% save('data/sg/CJ6seg-sg-inv.mat','X','y','-v7.3');