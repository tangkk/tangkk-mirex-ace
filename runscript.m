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
% trainingDataGenNSeg('raw1.mat','JayChou29List.txt',6, 1)% encoded in -v5
% trainingDataGenVarLen('raw2.mat','JayChou29List.txt', 1)% encoded in -v7.3
% trainingDataGenSongWise('raw3.mat','JayChou29List.txt', 1)% encoded in -v7.3
% trainingDataGenNSeg('raw4.mat','TheBeatles180List.txt',6, 1)% encoded in -v5
% trainingDataGenVarLen('raw5.mat','TheBeatles180List.txt', 1)% encoded in -v7.3
% trainingDataGenSongWise('raw6.mat','TheBeatles180List.txt', 1)% encoded in -v7.3

% trainingDataGenVarLen('raw7.mat','JayChou29List.txt', 0)% encoded in -v7.3
% trainingDataGenVarLen('raw8.mat','TheBeatles180List.txt', 0)% encoded in -v7.3
% trainingDataGenSongWise('raw9.mat','JayChou29List.txt', 0)% encoded in -v7.3

% %%%%%%%%%%%%%%%%%%Save intermediate results for faster comparison%%%%%%%%%%%%%%%%%%
% tangkkace('30','JayChou29List.txt','1','JayChou29ListBUB.mat');
% tangkkace('30','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat');
% tangkkace('30','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat');
% tangkkace('30','CNPop20List.txt','1','CNPop20ListBUB.mat');

% %%%%%%%%%%%%%%%%%%Work With Theano NN%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% CNPop - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-mlp-1 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-mlp-2 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-mlp-3 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-mlp-4 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-mlp-5 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-mlp-6 CNPop20List.txt;

tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-dbn-1 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-dbn-2 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-dbn-3 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-dbn-4 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-dbn-5 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-dbn-6 CNPop20List.txt;

tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-lstm-1 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-lstm-2 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-lstm-3 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-lstm-4 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-lstm-5 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-lstm-6 CNPop20List.txt;

tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-blstm-1 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-blstm-2 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-blstm-3 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-blstm-4 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-blstm-5 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-blstm-6 CNPop20List.txt;

tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-1.pkl');evaluateCP cnpop-knn-1 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-2.pkl');evaluateCP cnpop-knn-2 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-3.pkl');evaluateCP cnpop-knn-3 CNPop20List.txt;

tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-1.pkl');evaluateCP cnpop-svm-1 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-2.pkl');evaluateCP cnpop-svm-2 CNPop20List.txt;
tangkkace('30','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-3.pkl');evaluateCP cnpop-svm-3 CNPop20List.txt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% CaroleKingQueen - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-mlp-1 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-mlp-2 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-mlp-3 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-mlp-4 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-mlp-5 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-mlp-6 CaroleKingQueen26List.txt;

tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-dbn-1 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-dbn-2 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-dbn-3 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-dbn-4 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-dbn-5 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-dbn-6 CaroleKingQueen26List.txt;

tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-lstm-1 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-lstm-2 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-lstm-3 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-lstm-4 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-lstm-5 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-lstm-6 CaroleKingQueen26List.txt;

tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-blstm-1 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-blstm-2 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-blstm-3 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-blstm-4 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-blstm-5 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-blstm-6 CaroleKingQueen26List.txt;

tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-1.pkl');evaluateCP kingqueen-knn-1 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-2.pkl');evaluateCP kingqueen-knn-2 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-3.pkl');evaluateCP kingqueen-knn-3 CaroleKingQueen26List.txt;

tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-1.pkl');evaluateCP kingqueen-svm-1 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-2.pkl');evaluateCP kingqueen-svm-2 CaroleKingQueen26List.txt;
tangkkace('30','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-3.pkl');evaluateCP kingqueen-svm-3 CaroleKingQueen26List.txt;