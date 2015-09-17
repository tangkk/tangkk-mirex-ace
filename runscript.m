% 17-19 NN based, 20 baseline, 10 heuristic, 15 confusion matrix based
% 21 nn2(data-J-12-key.mat,120,544,1000,1)-71.6 + LM-J system
% 22 nn2(data-J-12-key.mat,120,544,1000,1)-71.6 + LM-B system
% 23 revconf-B-10 system
% 24 nn2(data-B-12-key.mat,120,544,1000,1)-62.84 system
% 25 nn2(data-B-12-key.mat,120,544,1000,1)-62.84 + LM-B system
% 26 dbn2(500,500,277,.02,.1,1000,10000,data-J-12-key) system

% tangkkace('22','tempList.txt');evaluateCP tempList-22 tempList.txt;
% tangkkace('23','tempList.txt');evaluateCP tempList-23 tempList.txt;
% tangkkace('24','tempList.txt');evaluateCP tempList-24 tempList.txt;
% tangkkace('25','tempList.txt');evaluateCP tempList-25 tempList.txt;
tangkkace('26','tempList.txt');evaluateCP tempList-26 tempList.txt;

% % run nn2(data-J-12-key.mat,120,544,1000,1)-71.6 + LM-B system
% tangkkace('22','JayChou29List.txt');evaluateCP jaychou-22 JayChou29List.txt;
% tangkkace('22','TheBeatles180List.txt');evaluateCP thebeatles-22 TheBeatles180List.txt;

% % run revconf-B-10
% tangkkace('23','JayChou29List.txt');evaluateCP jaychou-23 JayChou29List.txt;
% tangkkace('23','TheBeatles180List.txt');evaluateCP thebeatles-23 TheBeatles180List.txt;

% % run nn2(data-B-12-key.mat,120,544,1000,1)-62.84 system
% tangkkace('24','JayChou29List.txt');evaluateCP jaychou-24 JayChou29List.txt;
% tangkkace('24','TheBeatles180List.txt');evaluateCP thebeatles-24 TheBeatles180List.txt;

% % run nn2(data-B-12-key.mat,120,544,1000,1)-62.84 + LM-B system
% tangkkace('25','JayChou29List.txt');evaluateCP jaychou-25 JayChou29List.txt;
% tangkkace('25','TheBeatles180List.txt');evaluateCP thebeatles-25 TheBeatles180List.txt;

% run dbn2(500,500,277,.02,.1,1000,10000,data-J-12-key) system
tangkkace('26','JayChou29List.txt');evaluateCP jaychou-26 JayChou29List.txt;
tangkkace('26','TheBeatles180List.txt');evaluateCP thebeatles-26 TheBeatles180List.txt;

% disp('dbntest');
% dbn1(1000,13,.02,.1,100,1000,'dbntest');
% dbn2(500,500,13,.02,.1,100,1000,'dbntest');

% disp('data-J-12-key-root');
% datagen('data-J-12-key-root.mat','data-B-12-key-root.mat');
% dbn1(1000,13,.02,.1,1000,10000,'data');
% dbn2(500,500,13,.02,.1,1000,10000,'data');
% dbn2(1000,1000,13,.02,.1,1000,10000,'data');

% disp('data-J-12-key-treble');
% datagen('data-J-12-key-treble.mat','data-B-12-key-treble.mat');
% dbn1(1000,19,.02,.1,1000,10000,'data');
% dbn2(500,500,19,.02,.1,1000,10000,'data');
% dbn2(1000,1000,19,.02,.1,1000,10000,'data');

% disp('data-J-12-key-bass');
% datagen('data-J-12-key-bass.mat','data-B-12-key-bass.mat');
% dbn1(1000,13,.02,.1,1000,10000,'data');
% dbn2(500,500,13,.02,.1,1000,10000,'data');
% dbn2(1000,1000,13,.02,.1,1000,10000,'data');

% disp('data-J-ns-12-key-root');
% datagen('data-J-ns-12-key-root.mat','data-B-ns-12-key-root.mat');
% dbn1(1000,13,.02,.1,1000,10000,'data');
% dbn2(500,500,13,.02,.1,1000,10000,'data');
% dbn2(1000,1000,13,.02,.1,1000,10000,'data');

% disp('data-J-ns-12-key-treble');
% datagen('data-J-ns-12-key-treble.mat','data-B-ns-12-key-treble.mat');
% dbn1(1000,19,.02,.1,1000,10000,'data');
% dbn2(500,500,19,.02,.1,1000,10000,'data');
% dbn2(1000,1000,19,.02,.1,1000,10000,'data');

% disp('data-J-ns-12-key-bass');
% datagen('data-J-ns-12-key-bass.mat','data-B-ns-12-key-bass.mat');
% dbn1(1000,13,.02,.1,1000,10000,'data');
% dbn2(500,500,13,.02,.1,1000,10000,'data');
% dbn2(1000,1000,13,.02,.1,1000,10000,'data');

