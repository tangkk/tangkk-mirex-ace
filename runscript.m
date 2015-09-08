% 17-19 NN based, 20 baseline, 10 heuristic, 15 confusion matrix based

% run a small test case
tangkkace('17','tempList.txt');evaluateCP test-17 tempList.txt;
tangkkace('18','tempList.txt');evaluateCP test-18 tempList.txt;
tangkkace('19','tempList.txt');evaluateCP test-19 tempList.txt;
tangkkace('20','tempList.txt');evaluateCP test-20 tempList.txt;

% run new param set on JayChou29 data set
tangkkace('17','JayChou29List.txt');evaluateCP jaychou-17 JayChou29List.txt;
tangkkace('18','JayChou29List.txt');evaluateCP jaychou-18 JayChou29List.txt;
tangkkace('19','JayChou29List.txt');evaluateCP jaychou-19 JayChou29List.txt;
tangkkace('20','JayChou29List.txt');evaluateCP jaychou-20 JayChou29List.txt;

% run old param set on TheBeatles data set
tangkkace('10','TheBeatles180List.txt');evaluateCP thebeatles-10 TheBeatles180List.txt;
tangkkace('15','TheBeatles180List.txt');evaluateCP thebeatles-15 TheBeatles180List.txt;

% run new param set on TheBeatles data set
tangkkace('17','TheBeatles180List.txt');evaluateCP thebeatles-17 TheBeatles180List.txt;
tangkkace('18','TheBeatles180List.txt');evaluateCP thebeatles-18 TheBeatles180List.txt;
tangkkace('19','TheBeatles180List.txt');evaluateCP thebeatles-19 TheBeatles180List.txt;
tangkkace('20','TheBeatles180List.txt');evaluateCP thebeatles-20 TheBeatles180List.txt;

% run full model chord correction (language model + acoustic model) on both
% data set
tangkkace('21','JayChou29List.txt');evaluateCP jaychou-21 JayChou29List.txt;
tangkkace('21','TheBeatles180List.txt');evaluateCP thebeatles-21 TheBeatles180List.txt;
tangkkace('22','JayChou29List.txt');evaluateCP jaychou-22 JayChou29List.txt;
tangkkace('22','TheBeatles180List.txt');evaluateCP thebeatles-22 TheBeatles180List.txt;

