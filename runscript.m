% %%%%%%%%%%%%%%%%%%MIREX 2015%%%%%%%%%%%%%%%%%%
% 20 baseline
% 10 heuristic
% 15 revconf-J-10 based
% 23 revconf-B-10 system
% 19 nn2(data-J-12-key.mat,120,544,1000,1)-71.6
% 21 nn2(data-J-12-key.mat,120,544,1000,1)-71.6 + LM-J
% 22 nn2(data-J-12-key.mat,120,544,1000,1)-71.6 + LM-B
% 24 nn2(data-B-12-key.mat,120,544,1000,1)-62.84
% 25 nn2(data-B-12-key.mat,120,544,1000,1)-62.84 + LM-B
% 26 rbm2_bias(120,544,277,0.02,1000,10000,data-JB-12,0)-nn2_bias(120,544,277,1000,1,init_model,data-JB-12)
% 27 rbm2_bias(120,544,277,0.02,1000,10000,data-J-12,0)-nn2_bias(120,544,277,1000,1,init_model,data-J-12)
% 28 rbm2_bias(120,544,277,0.02,1000,10000,data-J-12,0)-nn2_bias(120,544,277,1000,1,init_model,data-J-12)+LM-J
% 29 rbm2_bias(120,544,277,0.02,1000,10000,data-J-12,0)-nn2_bias(120,544,277,1000,1,init_model,data-J-12)+LM-B

% tangkkace('28','tempList.txt');evaluateCP tempList-28 tempList.txt;
% tangkkace('29','tempList.txt');evaluateCP tempList-29 tempList.txt;
% 
% tangkkace('28','JayChou29List.txt');evaluateCP jaychou-28 JayChou29List.txt;
% tangkkace('28','TheBeatles180List.txt');evaluateCP thebeatles-28 TheBeatles180List.txt;
% 
% tangkkace('29','JayChou29List.txt');evaluateCP jaychou-29 JayChou29List.txt;
% tangkkace('29','TheBeatles180List.txt');evaluateCP thebeatles-29 TheBeatles180List.txt;

% %%%%%%%%%%%%%%%%%%data generation processes%%%%%%%%%%%%%%%%%%
%%%%%%%%%%noinv%%%%%%%%%%%%%%%
% trainingDataGenNSeg('raw1.mat','JayChou29List.txt',6, 1)% encoded in -v5
% trainingDataGenVarLen('raw2.mat','JayChou29List.txt', 1)% encoded in -v7.3
% trainingDataGenSongWise('raw3.mat','JayChou29List.txt', 1)% encoded in -v7.3
% trainingDataGenNSeg('raw4.mat','TheBeatles180List.txt',6, 1)% encoded in -v5
% trainingDataGenVarLen('raw5.mat','TheBeatles180List.txt', 1)% encoded in -v7.3
% trainingDataGenSongWise('raw6.mat','TheBeatles180List.txt', 1)% encoded in -v7.3

%%%%%%%%%%inv%%%%%%%%%%%%%%%
% trainingDataGenVarLen('raw7.mat','JayChou29List.txt', 0)% encoded in -v7.3
% trainingDataGenVarLen('raw8.mat','TheBeatles180List.txt', 0)% encoded in -v7.3
% trainingDataGenSongWise('raw9.mat','JayChou29List.txt', 0)% encoded in -v7.3

%%%%%%%%%%no7%%%%%%%%%%%%%%%
% trainingDataGenNSeg('rawB.mat','TheBeatles180List.txt',6, 0, 1)% encoded in -v5
% trainingDataGenNSeg('rawJ.mat','JayChou29List.txt',6, 0, 1)% encoded in -v5
% trainingDataGenSongWise('rawJsong.mat','JayChou29List.txt', 0, 1)% encoded in -v7.3
% trainingDataGenSongWise('rawBsong.mat','TheBeatles180List.txt', 0, 1)% encoded in -v7.3


% %%%%%%%%%%%%%%%%%%Save intermediate results for faster comparison%%%%%%%%%%%%%%%%%%
% tangkkace('30','JayChou29List.txt','-1','JayChou29ListBUB.mat');
% tangkkace('30','TheBeatles180List.txt','-1','TheBeatles180ListBUB.mat');
% tangkkace('30','CaroleKingQueen26List.txt','-1','CaroleKingQueen26ListBUB.mat');
% tangkkace('30','CNPop20List.txt','-1','CNPop20ListBUB.mat');
% tangkkace('30','tempList.txt','-1','tempListBUB.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% J-CNPop - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-mlp-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-mlp-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-mlp-3 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-mlp-4 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-mlp-5 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-mlp-6 CNPop20List.txt;
% 
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-dbn-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-dbn-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-dbn-3 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-dbn-4 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-dbn-5 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-dbn-6 CNPop20List.txt;
% 
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-lstm-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-lstm-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-lstm-3 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-lstm-4 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-lstm-5 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-lstm-6 CNPop20List.txt;

% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-blstm-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-blstm-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-blstm-3 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-blstm-4 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-blstm-5 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-blstm-6 CNPop20List.txt;
% 
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-1.pkl');evaluateCP cnpop-knn-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-2.pkl');evaluateCP cnpop-knn-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-3.pkl');evaluateCP cnpop-knn-3 CNPop20List.txt;
% 
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-1.pkl');evaluateCP cnpop-svm-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-2.pkl');evaluateCP cnpop-svm-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-3.pkl');evaluateCP cnpop-svm-3 CNPop20List.txt;

% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlpJ6segInvList.txt');evaluateCP cnpop-mlp-ens CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbnJ6segInvList.txt');evaluateCP cnpop-dbn-ens CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstmJ6segInvList.txt');evaluateCP cnpop-lstm-ens CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstmJ6segInvList.txt');evaluateCP cnpop-blstm-ens CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','knnJ6segInvList.txt');evaluateCP cnpop-knn-ens CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','svmJ6segInvList.txt');evaluateCP cnpop-svm-ens CNPop20List.txt; 
% 
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mixJ6segInvList.txt');evaluateCP cnpop-mix-ens CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','allJ6segInvList.txt');evaluateCP cnpop-all-ens CNPop20List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% J-CNPop - NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','CNPop20List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-mlp-nnhmm-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-mlp-nnhmm-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-mlp-nnhmm-3 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-mlp-nnhmm-4 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-mlp-nnhmm-5 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-mlp-nnhmm-6 CNPop20List.txt;
% 
% tangkkace('30','CNPop20List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-dbn-nnhmm-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-dbn-nnhmm-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-dbn-nnhmm-3 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-dbn-nnhmm-4 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-dbn-nnhmm-5 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-dbn-nnhmm-6 CNPop20List.txt;
% 
% tangkkace('30','CNPop20List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-lstm-nnhmm-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-lstm-nnhmm-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-lstm-nnhmm-3 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-lstm-nnhmm-4 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-lstm-nnhmm-5 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-lstm-nnhmm-6 CNPop20List.txt;
% 
% tangkkace('30','CNPop20List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-blstm-nnhmm-1 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-blstm-nnhmm-2 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-blstm-nnhmm-3 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-blstm-nnhmm-4 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-blstm-nnhmm-5 CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-blstm-nnhmm-6 CNPop20List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% B-CaroleKingQueen - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-mlp-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-mlp-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-mlp-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-mlp-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-mlp-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-mlp-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-dbn-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-dbn-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-dbn-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-dbn-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-dbn-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-dbn-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-lstm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-lstm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-lstm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-lstm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-lstm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-lstm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-blstm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-blstm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-blstm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-blstm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-blstm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-blstm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-1.pkl');evaluateCP kingqueen-knn-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-2.pkl');evaluateCP kingqueen-knn-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-3.pkl');evaluateCP kingqueen-knn-3 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-1.pkl');evaluateCP kingqueen-svm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-2.pkl');evaluateCP kingqueen-svm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-3.pkl');evaluateCP kingqueen-svm-3 CaroleKingQueen26List.txt;

% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlpB6segInvList.txt');evaluateCP kingqueen-mlp-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbnB6segInvList.txt');evaluateCP kingqueen-dbn-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstmB6segInvList.txt');evaluateCP kingqueen-lstm-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstmB6segInvList.txt');evaluateCP kingqueen-blstm-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knnB6segInvList.txt');evaluateCP kingqueen-knn-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svmB6segInvList.txt');evaluateCP kingqueen-svm-ens CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mixB6segInvList.txt');evaluateCP kingqueen-mix-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','allB6segInvList.txt');evaluateCP kingqueen-all-ens CaroleKingQueen26List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% B-CaroleKingQueen - NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-mlp-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-mlp-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-mlp-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-mlp-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-mlp-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-mlp-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-dbn-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-dbn-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-dbn-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-dbn-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-dbn-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-dbn-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-lstm-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-lstm-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-lstm-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-lstm-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-lstm-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-lstm-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-blstm-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-blstm-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-blstm-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-blstm-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-blstm-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-blstm-nnhmm-6 CaroleKingQueen26List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CaroleKingQueen - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-kingqueen-mlp-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-kingqueen-mlp-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-kingqueen-mlp-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-kingqueen-mlp-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-kingqueen-mlp-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-kingqueen-mlp-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-kingqueen-dbn-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-kingqueen-dbn-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-kingqueen-dbn-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-kingqueen-dbn-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-kingqueen-dbn-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-kingqueen-dbn-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-kingqueen-lstm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-kingqueen-lstm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-kingqueen-lstm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-kingqueen-lstm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-kingqueen-lstm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-kingqueen-lstm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-kingqueen-blstm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-kingqueen-blstm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-kingqueen-blstm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-kingqueen-blstm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-kingqueen-blstm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-kingqueen-blstm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-J6seg-ch-inv-1.pkl');evaluateCP J-kingqueen-knn-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-J6seg-ch-inv-2.pkl');evaluateCP J-kingqueen-knn-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-J6seg-ch-inv-3.pkl');evaluateCP J-kingqueen-knn-3 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-J6seg-ch-inv-1.pkl');evaluateCP J-kingqueen-svm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-J6seg-ch-inv-2.pkl');evaluateCP J-kingqueen-svm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-J6seg-ch-inv-3.pkl');evaluateCP J-kingqueen-svm-3 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlpJ6segInvList.txt');evaluateCP J-kingqueen-mlp-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbnJ6segInvList.txt');evaluateCP J-kingqueen-dbn-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstmJ6segInvList.txt');evaluateCP J-kingqueen-lstm-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstmJ6segInvList.txt');evaluateCP J-kingqueen-blstm-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knnJ6segInvList.txt');evaluateCP J-kingqueen-knn-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svmJ6segInvList.txt');evaluateCP J-kingqueen-svm-ens CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mixJ6segInvList.txt');evaluateCP J-kingqueen-mix-ens CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','allJ6segInvList.txt');evaluateCP J-kingqueen-all-ens CaroleKingQueen26List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CaroleKingQueen - NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-kingqueen-mlp-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-kingqueen-mlp-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-kingqueen-mlp-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-kingqueen-mlp-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-kingqueen-mlp-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-kingqueen-mlp-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-kingqueen-dbn-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-kingqueen-dbn-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-kingqueen-dbn-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-kingqueen-dbn-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-kingqueen-dbn-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-kingqueen-dbn-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-kingqueen-lstm-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-kingqueen-lstm-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-kingqueen-lstm-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-kingqueen-lstm-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-kingqueen-lstm-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-kingqueen-lstm-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-kingqueen-blstm-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-kingqueen-blstm-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-kingqueen-blstm-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-kingqueen-blstm-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-kingqueen-blstm-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('30','CaroleKingQueen26List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-kingqueen-blstm-nnhmm-6 CaroleKingQueen26List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBeatles - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-thebeatles-mlp-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-thebeatles-mlp-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-thebeatles-mlp-3 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-thebeatles-mlp-4 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-thebeatles-mlp-5 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-thebeatles-mlp-6 TheBeatles180List.txt;

% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-thebeatles-dbn-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-thebeatles-dbn-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-thebeatles-dbn-3 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-thebeatles-dbn-4 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-thebeatles-dbn-5 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-thebeatles-dbn-6 TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-thebeatles-lstm-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-thebeatles-lstm-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-thebeatles-lstm-3 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-thebeatles-lstm-4 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-thebeatles-lstm-5 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-thebeatles-lstm-6 TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-thebeatles-blstm-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-thebeatles-blstm-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-thebeatles-blstm-3 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-thebeatles-blstm-4 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-thebeatles-blstm-5 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-thebeatles-blstm-6 TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','knn-J6seg-ch-inv-1.pkl');evaluateCP J-thebeatles-knn-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','knn-J6seg-ch-inv-2.pkl');evaluateCP J-thebeatles-knn-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','knn-J6seg-ch-inv-3.pkl');evaluateCP J-thebeatles-knn-3 TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','svm-J6seg-ch-inv-1.pkl');evaluateCP J-thebeatles-svm-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','svm-J6seg-ch-inv-2.pkl');evaluateCP J-thebeatles-svm-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','svm-J6seg-ch-inv-3.pkl');evaluateCP J-thebeatles-svm-3 TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlpJ6segInvList.txt');evaluateCP J-thebeatles-mlp-ens TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbnJ6segInvList.txt');evaluateCP J-thebeatles-dbn-ens TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstmJ6segInvList.txt');evaluateCP J-thebeatles-lstm-ens TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstmJ6segInvList.txt');evaluateCP J-thebeatles-blstm-ens TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','knnJ6segInvList.txt');evaluateCP J-thebeatles-knn-ens TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','svmJ6segInvList.txt');evaluateCP J-thebeatles-svm-ens TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mixJ6segInvList.txt');evaluateCP J-thebeatles-mix-ens TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','allJ6segInvList.txt');evaluateCP J-thebeatles-all-ens TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBeatles - NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','TheBeatles180List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-thebeatles-mlp-nnhmm-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-thebeatles-mlp-nnhmm-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-thebeatles-mlp-nnhmm-3 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-thebeatles-mlp-nnhmm-4 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-thebeatles-mlp-nnhmm-5 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-thebeatles-mlp-nnhmm-6 TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-thebeatles-dbn-nnhmm-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-thebeatles-dbn-nnhmm-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-thebeatles-dbn-nnhmm-3 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-thebeatles-dbn-nnhmm-4 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-thebeatles-dbn-nnhmm-5 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-thebeatles-dbn-nnhmm-6 TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-thebeatles-lstm-nnhmm-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-thebeatles-lstm-nnhmm-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-thebeatles-lstm-nnhmm-3 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-thebeatles-lstm-nnhmm-4 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-thebeatles-lstm-nnhmm-5 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-thebeatles-lstm-nnhmm-6 TheBeatles180List.txt;
% 
% tangkkace('30','TheBeatles180List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-thebeatles-blstm-nnhmm-1 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-thebeatles-blstm-nnhmm-2 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-thebeatles-blstm-nnhmm-3 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-thebeatles-blstm-nnhmm-4 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-thebeatles-blstm-nnhmm-5 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','1','x.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-thebeatles-blstm-nnhmm-6 TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CNPop - ch-SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','CNPop20List.txt','3','CNPop20ListBUB.mat','bctc-Jsong-ch-inv-i.npz');evaluateCP cnpop-bctc CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','3','CNPop20ListBUB.mat','ctc-Jsong-ch-inv-i.npz');evaluateCP cnpop-ctc CNPop20List.txt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBeatles - ch-SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','bctc-Jsong-ch-inv-i.npz');evaluateCP thebeatles-bctc TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','ctc-Jsong-ch-inv-i.npz');evaluateCP thebeatles-ctc TheBeatles180List.txt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CNPop - ns-SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','CNPop20List.txt','4','CNPop20ListBUBns.mat','ctc-Jsong-ns-inv-i.npz');evaluateCP cnpop-ns-ctc CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','4','CNPop20ListBUBns.mat','bctc-Jsong-ns-inv-i.npz');evaluateCP cnpop-ns-bctc CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','4','CNPop20ListBUBns.mat','ctc-Jsong-ns-inv-ii.npz');evaluateCP cnpop-ns-ctcsg CNPop20List.txt;
% tangkkace('30','CNPop20List.txt','4','CNPop20ListBUBns.mat','bctc-Jsong-ns-inv-ii.npz');evaluateCP cnpop-ns-bctcsg CNPop20List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBealtes - ns-SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','ctc-Jsong-ns-inv-i.npz');evaluateCP thebeatles-ns-ctc TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','bctc-Jsong-ns-inv-i.npz');evaluateCP thebeatles-ns-bctc TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','ctc-Jsong-ns-inv-ii.npz');evaluateCP thebeatles-ns-ctcsg TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','bctc-Jsong-ns-inv-ii.npz');evaluateCP thebeatles-ns-bctcsg TheBeatles180List.txt;

% tangkkace('30','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','bctc-Jsong-ch-no7-i.npz');evaluateCP thebeatles-ch-bctc-no7 TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','bctc-Jsong-ns-no7-i.npz');evaluateCP thebeatles-ns-bctc-no7 TheBeatles180List.txt;

% tangkkace('30','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','bctc-Jsong-ch-noinv-i.npz');evaluateCP thebeatles-ch-bctc-noinv TheBeatles180List.txt;
% tangkkace('30','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','bctc-Jsong-ns-noinv-i.npz');evaluateCP thebeatles-ns-bctc-noinv TheBeatles180List.txt;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Spectrogram Data Gen - SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% trainingDataGenNSeg('raw1.mat','CNPopJayChou49List.txt',6,0,0)
% trainingDataGenSgSongWise('raw2.mat','CNPopJayChou49List.txt',0,0)
% trainingDataGenSgNSegPinv('raw1.mat','CNPopJayChou49List.txt',6,0,0)
% trainingDataGenSgSongWisePinv('raw2.mat','CNPopJayChou49List.txt',0,0)
% trainingDataGenWfSongWise('raw5.mat','CNPopJayChou49List.txt',0,0)

% trainingDataGenSgSongWise('raw1.mat','JayChou29List.txt',0,0)
% trainingDataGenSgSongWisePinv('raw2.mat','JayChou29List.txt',0,0)

% trainingDataGenWfSongWise('raw3.mat','JayChou29List.txt',0,0)
% trainingDataGenWfSongWisePinv('raw4.mat','JayChou29List.txt',0,0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Saving ns sets %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('30','tempList.txt','-1','tempListBUB.mat');
% tangkkace('30','tempList.txt','-2','tempListBUBns.mat');
% tangkkace('30','tempList.txt','-3','tempListBUBsg.mat');
% tangkkace('30','CNPop20List.txt','-2','CNPop20ListBUBns.mat');
% tangkkace('30','CNPop20List.txt','-3','CNPop20ListBUBsg.mat');
% tangkkace('30','TheBeatles180List.txt','-2','TheBeatles180ListBUBns.mat');
% tangkkace('30','TheBeatles180List.txt','-3','TheBeatles180ListBUBsg.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Simple Test %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('20','tempList.txt','0','0','0');evaluateCP tempList tempList.txt;

% tangkkace('30','tempList.txt','-1','tempListBUB.mat');
% tangkkace('30','tempList.txt','3','tempListBUB.mat','bctc-Jsong-ch-no7-i.npz');evaluateCP temp-ch-bctc-no7 tempList.txt;

% tangkkace('30','tempList.txt','-2','tempListBUBns.mat');
% tangkkace('30','tempList.txt','4','tempListBUBns.mat','bctc-Jsong-ns-no7-i.npz');evaluateCP temp-ns-bctc-no7 tempList.txt;
