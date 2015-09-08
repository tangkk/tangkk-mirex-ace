% 17-19 NN based, 20 baseline, 10 heuristic, 15 confusion matrix based
% 21 nn2(data-J-12-key.mat,120,544,1000,1)-71.6 + LM-J system
% 22 nn2(data-J-12-key.mat,120,544,1000,1)-71.6 + LM-B system
% 23 revconf-B-10 system
% 24 nn2(data-B-12-key.mat,120,544,1000,1)-62.84 system
% 25 nn2(data-B-12-key.mat,120,544,1000,1)-62.84 + LM-B system

tangkkace('22','tempList.txt');evaluateCP tempList-22 tempList.txt;
tangkkace('23','tempList.txt');evaluateCP tempList-23 tempList.txt;
tangkkace('24','tempList.txt');evaluateCP tempList-24 tempList.txt;
tangkkace('25','tempList.txt');evaluateCP tempList-25 tempList.txt;

% run nn2(data-J-12-key.mat,120,544,1000,1)-71.6 + LM-B system
tangkkace('22','JayChou29List.txt');evaluateCP jaychou-22 JayChou29List.txt;
tangkkace('22','TheBeatles180List.txt');evaluateCP thebeatles-22 TheBeatles180List.txt;

% run revconf-B-10
tangkkace('23','JayChou29List.txt');evaluateCP jaychou-23 JayChou29List.txt;
tangkkace('23','TheBeatles180List.txt');evaluateCP thebeatles-23 TheBeatles180List.txt;

% run nn2(data-B-12-key.mat,120,544,1000,1)-62.84 system
tangkkace('24','JayChou29List.txt');evaluateCP jaychou-24 JayChou29List.txt;
tangkkace('24','TheBeatles180List.txt');evaluateCP thebeatles-24 TheBeatles180List.txt;

% run nn2(data-B-12-key.mat,120,544,1000,1)-62.84 + LM-B system
% run nn2(data-B-12-key.mat,120,544,1000,1)-62.84 system
tangkkace('25','JayChou29List.txt');evaluateCP jaychou-25 JayChou29List.txt;
tangkkace('25','TheBeatles180List.txt');evaluateCP thebeatles-25 TheBeatles180List.txt;
