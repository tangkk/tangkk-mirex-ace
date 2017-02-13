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
%%%%%%%%%%inv%%%%%%%%%%%%%%%
% trainingDataGenVarLen('raw1.mat','CJK75List.txt', 0, 0)% encoded in -v7.3
% trainingDataGenVarLen('raw7.mat','JayChou29List.txt', 0, 0)% encoded in -v7.3
% trainingDataGenVarLen('raw8.mat','TheBeatles180List.txt', 0, 0)% encoded in -v7.3
% trainingDataGenSongWise('raw9.mat','JayChou29List.txt', 0)% e ncoded in -v7.3
% trainingDataGenSongWise('raw1.mat','CNPopJayChou49List.txt', 0, 0)% encoded in -v7.3
% trainingDataGenSongWise('raw2.mat','CJK75List.txt', 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw10.mat','CNPopJayChou49List.txt',6, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw11.mat','CJK75List.txt',6, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw12.mat','TheBeatles180List.txt',6, 0, 0)% encoded in -v7.3
% trainingDataGenSongWise('raw6.mat','USPop195List.txt', 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw11.mat','USPop195List.txt',6, 0, 0)% encoded in -v7.3
% trainingDataGenSongWise('raw1.mat','USPop191List.txt', 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw2.mat','USPop191List.txt',6, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw1.mat','RWC100List.txt',6, 0, 0)% encoded in -v7.3
% trainingDataGenSongWise('raw2.mat','RWC100List.txt', 0, 0)% encoded in -v7.3

% trainingDataGenNSeg('raw1_.mat','CJK75List.txt',1, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw5_.mat','CJK75List.txt',2, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw2_.mat','CJK75List.txt',3, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw3_.mat','CJK75List.txt',9, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw4_.mat','CJK75List.txt',12, 0, 0)% encoded in -v7.3
% 
% trainingDataGenNSeg('raw1.mat','CJKU266List.txt',1, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw5.mat','CJKU266List.txt',2, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw2.mat','CJKU266List.txt',3, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw3.mat','CJKU266List.txt',9, 0, 0)% encoded in -v7.3
% trainingDataGenNSeg('raw4.mat','CJKU266List.txt',12, 0, 0)% encoded in -v7.3

%%%%%%%%%%noinv%%%%%%%%%%%%%%%
% trainingDataGenNSeg('raw1.mat','JayChou29List.txt',6, 1)% encoded in -v5
% trainingDataGenVarLen('raw2.mat','JayChou29List.txt', 1, 0)% encoded in -v7.3
% trainingDataGenSongWise('raw3.mat','JayChou29List.txt', 1)% encoded in -v7.3
% trainingDataGenNSeg('raw4.mat','TheBeatles180List.txt',6, 1)% encoded in -v5
% trainingDataGenVarLen('raw5.mat','TheBeatles180List.txt', 1, 0)% encoded in -v7.3
% trainingDataGenSongWise('raw6.mat','TheBeatles180List.txt', 1)% encoded in -v7.3
% trainingDataGenJazzNSeg('rawjazz.mat','JazzGuitar99List.txt',6);
% trainingDataGenJazzSongWise('rawjazzsong.mat','JazzGuitar99List.txt')% encoded in -v7.3
% trainingDataGenJazzNSeg('rawjazz1.mat','JazzImpro96List.txt',6);
% trainingDataGenJazzSongWise('rawjazzsong1.mat','JazzImpro96List.txt')% encoded in -v7.3
% trainingDataGenJazzNSeg('rawjazz2.mat','PracJazz76List.txt',6);
% trainingDataGenJazzSongWise('rawjazzsong2.mat','PracJazz76List.txt')% encoded in -v7.3


%%%%%%%%%%no7%%%%%%%%%%%%%%%
% trainingDataGenNSeg('rawB.mat','TheBeatles180List.txt',6, 0, 1)% encoded in -v5
% trainingDataGenNSeg('rawJ.mat','JayChou29List.txt',6, 0, 1)% encoded in -v5
% trainingDataGenSongWise('rawJsong.mat','JayChou29List.txt', 0, 1)% encoded in -v7.3
% trainingDataGenSongWise('rawBsong.mat','TheBeatles180List.txt', 0, 1)% encoded in -v7.3

%%%%%%%%%%Mm%%%%%%%%%%%%%%%
% trainingDataGenMmNSeg('rawCJK.mat','CJK75List.txt',6)
% trainingDataGenMmNSeg('rawU.mat','USPop191List.txt',6)
% trainingDataGenMmNSeg('rawR.mat','RWC100List.txt',6)
%%%%%%%%%%Full%%%%%%%%%%%%%%%
% trainingDataGenFullNSeg('rawCJK-full.mat','CJK75List.txt',6)
% trainingDataGenFullNSeg('rawU-full.mat','USPop191List.txt',6)
% trainingDataGenFullNSeg('rawR-full.mat','RWC100List.txt',6)

%%%%%%%%%%cross-validation data%%%%%%%%%%%%%%%
% cvCombine('JK-1-ns.mat','JK-1-ch.mat','JK',1);
% cvCombine('JK-2-ns.mat','JK-2-ch.mat','JK',2);
% cvCombine('JK-3-ns.mat','JK-3-ch.mat','JK',3);
% cvCombine('JK-4-ns.mat','JK-4-ch.mat','JK',4);
% cvCombine('JK-5-ns.mat','JK-5-ch.mat','JK',5);
% cvCombine('JKU-1-ns.mat','JKU-1-ch.mat','JKU',1);
% cvCombine('JKU-2-ns.mat','JKU-2-ch.mat','JKU',2);
% cvCombine('JKU-3-ns.mat','JKU-3-ch.mat','JKU',3);
% cvCombine('JKU-4-ns.mat','JKU-4-ch.mat','JKU',4);
% cvCombine('JKU-5-ns.mat','JKU-5-ch.mat','JKU',5);
% cvCombine('JKUR-1-ns.mat','JKUR-1-ch.mat','JKUR',1);
% cvCombine('JKUR-2-ns.mat','JKUR-2-ch.mat','JKUR',2);
% cvCombine('JKUR-3-ns.mat','JKUR-3-ch.mat','JKUR',3);
% cvCombine('JKUR-4-ns.mat','JKUR-4-ch.mat','JKUR',4);
% cvCombine('JKUR-5-ns.mat','JKUR-5-ch.mat','JKUR',5);
% cvCombine('JKURB-1-ns.mat','JKURB-1-ch.mat','JKURB',1);
% cvCombine('JKURB-2-ns.mat','JKURB-2-ch.mat','JKURB',2);
% cvCombine('JKURB-3-ns.mat','JKURB-3-ch.mat','JKURB',3);
% cvCombine('JKURB-4-ns.mat','JKURB-4-ch.mat','JKURB',4);
% cvCombine('JKURB-5-ns.mat','JKURB-5-ch.mat','JKURB',5);

% cvCombine('JK',1,1);
% cvCombine('JK',2,1);
% cvCombine('JK',3,1);
% cvCombine('JK',4,1);
% cvCombine('JK',5,1);
% cvCombine('JKU',1,1);
% cvCombine('JKU',2,1);
% cvCombine('JKU',3,1);
% cvCombine('JKU',4,1);
% cvCombine('JKU',5,1);
% cvCombine('JKUR',1,1);
% cvCombine('JKUR',2,1);
% cvCombine('JKUR',3,1);
% cvCombine('JKUR',4,1);
% cvCombine('JKUR',5,1);
% cvCombine('JKURB',1,1);
% cvCombine('JKURB',2,1);
% cvCombine('JKURB',3,1);
% cvCombine('JKURB',4,1);
% cvCombine('JKURB',5,1);
% 
% cvCombine('JK',1,2);
% cvCombine('JK',2,2);
% cvCombine('JK',3,2);
% cvCombine('JK',4,2);
% cvCombine('JK',5,2);
% cvCombine('JKU',1,2);
% cvCombine('JKU',2,2);
% cvCombine('JKU',3,2);
% cvCombine('JKU',4,2);
% cvCombine('JKU',5,2);
% cvCombine('JKUR',1,2);
% cvCombine('JKUR',2,2);
% cvCombine('JKUR',3,2);
% cvCombine('JKUR',4,2);
% cvCombine('JKUR',5,2);
% cvCombine('JKURB',1,2);
% cvCombine('JKURB',2,2);
% cvCombine('JKURB',3,2);
% cvCombine('JKURB',4,2);
% cvCombine('JKURB',5,2);
% 
% cvCombine('JK',1,3);
% cvCombine('JK',2,3);
% cvCombine('JK',3,3);
% cvCombine('JK',4,3);
% cvCombine('JK',5,3);
% cvCombine('JKU',1,3);
% cvCombine('JKU',2,3);
% cvCombine('JKU',3,3);
% cvCombine('JKU',4,3);
% cvCombine('JKU',5,3);
% cvCombine('JKUR',1,3);
% cvCombine('JKUR',2,3);
% cvCombine('JKUR',3,3);
% cvCombine('JKUR',4,3);
% cvCombine('JKUR',5,3);
% cvCombine('JKURB',1,3);
% cvCombine('JKURB',2,3);
% cvCombine('JKURB',3,3);
% cvCombine('JKURB',4,3);
% cvCombine('JKURB',5,3);

% cvCombine('JK',1,9);
% cvCombine('JK',2,9);
% cvCombine('JK',3,9);
% cvCombine('JK',4,9);
% cvCombine('JK',5,9);
% cvCombine('JKU',1,9);
% cvCombine('JKU',2,9);
% cvCombine('JKU',3,9);
% cvCombine('JKU',4,9);
% cvCombine('JKU',5,9);
% 
% 
% cvCombine('JK',1,12);
% cvCombine('JK',2,12);
% cvCombine('JK',3,12);
% cvCombine('JK',4,12);
% cvCombine('JK',5,12);
% cvCombine('JKU',1,12);
% cvCombine('JKU',2,12);
% cvCombine('JKU',3,12);
% cvCombine('JKU',4,12);
% cvCombine('JKU',5,12);
% 
% foldCombine('C',1);
% foldCombine('C',2);
% foldCombine('C',3);
% foldCombine('C',9);
% foldCombine('C',12);


% cvCombine_songwise('JK',1);
% cvCombine_songwise('JK',2);
% cvCombine_songwise('JK',3);
% cvCombine_songwise('JK',4);
% cvCombine_songwise('JK',5);
% cvCombine_songwise('JKU',1);
% cvCombine_songwise('JKU',2);
% cvCombine_songwise('JKU',3);
% cvCombine_songwise('JKU',4);
% cvCombine_songwise('JKU',5);
% cvCombine_songwise('JKUR',1);
% cvCombine_songwise('JKUR',2);
% cvCombine_songwise('JKUR',3);
% cvCombine_songwise('JKUR',4);
% cvCombine_songwise('JKUR',5);
% cvCombine_songwise('JKURB',1);
% cvCombine_songwise('JKURB',2);
% cvCombine_songwise('JKURB',3);
% cvCombine_songwise('JKURB',4);
% cvCombine_songwise('JKURB',5);

% foldCombine_songwise('C');
% foldCombine_songwise('C');
% foldCombine_songwise('C');
% foldCombine_songwise('C');
% foldCombine_songwise('C');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% generate songwise data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cvRawGen('./data/cvraw-songwise/','./data/cvlist/');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Saving BUB sets %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','JayChou29List.txt','-1','JayChou29ListBUB.mat',0);
% tangkkace('SB','TheBeatles180List.txt','-1','TheBeatles180ListBUB.mat',0);
% tangkkace('SB','CaroleKingQueen26List.txt','-1','CaroleKingQueen26ListBUB.mat',0);
% tangkkace('SB','CNPop20List.txt','-1','CNPop20ListBUB.mat',0);
% tangkkace('SB','tempList.txt','-1','tempListBUB.mat',0);
% tangkkace('SB','tempList.txt','-1','tempListBUB.mat',0);
% tangkkace('SB','tempList.txt','-2','tempListBUBns.mat',0);
% tangkkace('SB','tempList.txt','-3','tempListBUBsg.mat',0);
% tangkkace('SB','CNPop20List.txt','-2','CNPop20ListBUBns.mat',0);
% tangkkace('SB','CNPop20List.txt','-3','CNPop20ListBUBsg.mat',0);
% tangkkace('SB','TheBeatles180List.txt','-2','TheBeatles180ListBUBns.mat',0);
% tangkkace('SB','TheBeatles180List.txt','-3','TheBeatles180ListBUBsg.mat',0);
% tangkkace('Jazz','JazzGuitar99List.txt','-1','JazzGuitar99ListBUB.mat',0);
% tangkkace('Jazz','JazzGuitar99List.txt','-2','JazzGuitar99ListBUBns.mat',0);
% tangkkace('Jazz','GaryBurton7List.txt','-1','GaryBurton7ListBUB.mat',0);
% tangkkace('Jazz','GaryBurton7List.txt','-2','GaryBurton7ListBUBns.mat',0);
% tangkkace('Jazz','JG106List.txt','-1','JG106ListBUB.mat',0);
% tangkkace('Jazz','JG106List.txt','-2','JG106ListBUBns.mat',0);
% tangkkace('SB','USPop195List.txt','-1','USPop195ListBUB.mat',0);
% tangkkace('SB','USPop195List.txt','-2','USPop195ListBUBns.mat',0);
% tangkkace('SB','USPop191List.txt','-1','USPop191ListBUB.mat',0);
% tangkkace('SB','USPop191List.txt','-2','USPop191ListBUBns.mat',0);
% tangkkace('SB','RWC100List.txt','-1','RWC100ListBUB.mat',0);
% tangkkace('SB','RWC100List.txt','-2','RWC100ListBUBns.mat',0);

% tangkkace('SB','data/cvlist/CaroleKingQueen26List-1.txt','-1','CaroleKingQueen26ListBUB-1.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26List-1.txt','-2','CaroleKingQueen26ListBUBns-1.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26List-2.txt','-1','CaroleKingQueen26ListBUB-2.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26List-2.txt','-2','CaroleKingQueen26ListBUBns-2.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26List-3.txt','-1','CaroleKingQueen26ListBUB-3.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26List-3.txt','-2','CaroleKingQueen26ListBUBns-3.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26List-4.txt','-1','CaroleKingQueen26ListBUB-4.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26List-4.txt','-2','CaroleKingQueen26ListBUBns-4.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26List-5.txt','-1','CaroleKingQueen26ListBUB-5.mat',0);
% tangkkace('SB','data/cvlist/CaroleKingQueen26 List-5.txt','-2','CaroleKingQueen26ListBUBns-5.mat',0);
% 
% tangkkace('SB','data/cvlist/CNPop20List-1.txt','-1','CNPop20ListBUB-1.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-1.txt','-2','CNPop20ListBUBns-1.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-2.txt','-1','CNPop20ListBUB-2.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-2.txt','-2','CNPop20ListBUBns-2.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-3.txt','-1','CNPop20ListBUB-3.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-3.txt','-2','CNPop20ListBUBns-3.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-4.txt','-1','CNPop20ListBUB-4.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-4.txt','-2','CNPop20ListBUBns-4.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-5.txt','-1','CNPop20ListBUB-5.mat',0);
% tangkkace('SB','data/cvlist/CNPop20List-5.txt','-2','CNPop20ListBUBns-5.mat',0);
% 
% tangkkace('SB','data/cvlist/JayChou29List-1.txt','-1','JayChou29ListBUB-1.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-1.txt','-2','JayChou29ListBUBns-1.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-2.txt','-1','JayChou29ListBUB-2.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-2.txt','-2','JayChou29ListBUBns-2.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-3.txt','-1','JayChou29ListBUB-3.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-3.txt','-2','JayChou29ListBUBns-3.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-4.txt','-1','JayChou29ListBUB-4.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-4.txt','-2','JayChou29ListBUBns-4.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-5.txt','-1','JayChou29ListBUB-5.mat',0);
% tangkkace('SB','data/cvlist/JayChou29List-5.txt','-2','JayChou29ListBUBns-5.mat',0);
% 
% tangkkace('SB','data/cvlist/RWC100List-1.txt','-1','RWC100ListBUB-1.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-1.txt','-2','RWC100ListBUBns-1.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-2.txt','-1','RWC100ListBUB-2.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-2.txt','-2','RWC100ListBUBns-2.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-3.txt','-1','RWC100ListBUB-3.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-3.txt','-2','RWC100ListBUBns-3.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-4.txt','-1','RWC100ListBUB-4.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-4.txt','-2','RWC100ListBUBns-4.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-5.txt','-1','RWC100ListBUB-5.mat',0);
% tangkkace('SB','data/cvlist/RWC100List-5.txt','-2','RWC100ListBUBns-5.mat',0);
% 
% tangkkace('SB','data/cvlist/TheBeatles180List-1.txt','-1','TheBeatles180ListBUB-1.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-1.txt','-2','TheBeatles180ListBUBns-1.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-2.txt','-1','TheBeatles180ListBUB-2.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-2.txt','-2','TheBeatles180ListBUBns-2.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-3.txt','-1','TheBeatles180ListBUB-3.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-3.txt','-2','TheBeatles180ListBUBns-3.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-4.txt','-1','TheBeatles180ListBUB-4.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-4.txt','-2','TheBeatles180ListBUBns-4.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-5.txt','-1','TheBeatles180ListBUB-5.mat',0);
% tangkkace('SB','data/cvlist/TheBeatles180List-5.txt','-2','TheBeatles180ListBUBns-5.mat',0);
% 
% tangkkace('SB','data/cvlist/USPop191List-1.txt','-1','USPop191ListBUB-1.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-1.txt','-2','USPop191ListBUBns-1.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-2.txt','-1','USPop191ListBUB-2.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-2.txt','-2','USPop191ListBUBns-2.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-3.txt','-1','USPop191ListBUB-3.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-3.txt','-2','USPop191ListBUBns-3.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-4.txt','-1','USPop191ListBUB-4.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-4.txt','-2','USPop191ListBUBns-4.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-5.txt','-1','USPop191ListBUB-5.mat',0);
% tangkkace('SB','data/cvlist/USPop191List-5.txt','-2','USPop191ListBUBns-5.mat',0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% J-CNPop - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-mlp-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-mlp-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-mlp-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-mlp-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-mlp-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-mlp-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-dbn-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-dbn-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-dbn-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-dbn-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-dbn-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-dbn-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-lstm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-lstm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-lstm-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-lstm-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-lstm-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-lstm-6 CNPop20List.txt;

% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-blstm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-blstm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-blstm-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-blstm-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-blstm-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-blstm-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-1.pkl');evaluateCP cnpop-knn-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-2.pkl');evaluateCP cnpop-knn-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','knn-J6seg-ch-inv-3.pkl');evaluateCP cnpop-knn-3 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-1.pkl');evaluateCP cnpop-svm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-2.pkl');evaluateCP cnpop-svm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','svm-J6seg-ch-inv-3.pkl');evaluateCP cnpop-svm-3 CNPop20List.txt;

% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','mlpJ6segInvList.txt');evaluateCP cnpop-mlp-ens CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','dbnJ6segInvList.txt');evaluateCP cnpop-dbn-ens CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','lstmJ6segInvList.txt');evaluateCP cnpop-lstm-ens CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','blstmJ6segInvList.txt');evaluateCP cnpop-blstm-ens CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','knnJ6segInvList.txt');evaluateCP cnpop-knn-ens CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','svmJ6segInvList.txt');evaluateCP cnpop-svm-ens CNPop20List.txt; 
% 
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','mixJ6segInvList.txt');evaluateCP cnpop-mix-ens CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','2','CNPop20ListBUB.mat','allJ6segInvList.txt');evaluateCP cnpop-all-ens CNPop20List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% J-CNPop - NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-mlp-nnhmm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-mlp-nnhmm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-mlp-nnhmm-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-mlp-nnhmm-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-mlp-nnhmm-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-mlp-nnhmm-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP cnpop-dbn-nnhmm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP cnpop-dbn-nnhmm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP cnpop-dbn-nnhmm-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP cnpop-dbn-nnhmm-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP cnpop-dbn-nnhmm-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP cnpop-dbn-nnhmm-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-lstm-nnhmm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-lstm-nnhmm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-lstm-nnhmm-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-lstm-nnhmm-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-lstm-nnhmm-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-lstm-nnhmm-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP cnpop-blstm-nnhmm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP cnpop-blstm-nnhmm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP cnpop-blstm-nnhmm-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP cnpop-blstm-nnhmm-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP cnpop-blstm-nnhmm-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','1','CNPop20ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP cnpop-blstm-nnhmm-6 CNPop20List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% B-CaroleKingQueen - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-mlp-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-mlp-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-mlp-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-mlp-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-mlp-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-mlp-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-dbn-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-dbn-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-dbn-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-dbn-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-dbn-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-dbn-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-lstm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-lstm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-lstm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-lstm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-lstm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-lstm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-blstm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-blstm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-blstm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-blstm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-blstm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-blstm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-1.pkl');evaluateCP kingqueen-knn-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-2.pkl');evaluateCP kingqueen-knn-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-B6seg-ch-inv-3.pkl');evaluateCP kingqueen-knn-3 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-1.pkl');evaluateCP kingqueen-svm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-2.pkl');evaluateCP kingqueen-svm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-B6seg-ch-inv-3.pkl');evaluateCP kingqueen-svm-3 CaroleKingQueen26List.txt;

% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlpB6segInvList.txt');evaluateCP kingqueen-mlp-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbnB6segInvList.txt');evaluateCP kingqueen-dbn-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstmB6segInvList.txt');evaluateCP kingqueen-lstm-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstmB6segInvList.txt');evaluateCP kingqueen-blstm-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knnB6segInvList.txt');evaluateCP kingqueen-knn-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svmB6segInvList.txt');evaluateCP kingqueen-svm-ens CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mixB6segInvList.txt');evaluateCP kingqueen-mix-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','allB6segInvList.txt');evaluateCP kingqueen-all-ens CaroleKingQueen26List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% B-CaroleKingQueen - NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-mlp-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-mlp-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-mlp-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-mlp-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-mlp-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-mlp-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-1.pkl');evaluateCP kingqueen-dbn-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-2.pkl');evaluateCP kingqueen-dbn-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-3.pkl');evaluateCP kingqueen-dbn-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-4.pkl');evaluateCP kingqueen-dbn-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-5.pkl');evaluateCP kingqueen-dbn-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-B6seg-ch-inv-[500,500]-6.pkl');evaluateCP kingqueen-dbn-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-lstm-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-lstm-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-lstm-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-lstm-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-lstm-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-lstm-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-1.npz');evaluateCP kingqueen-blstm-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-2.npz');evaluateCP kingqueen-blstm-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-3.npz');evaluateCP kingqueen-blstm-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-4.npz');evaluateCP kingqueen-blstm-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-5.npz');evaluateCP kingqueen-blstm-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-B6seg-ch-inv-[500]-6.npz');evaluateCP kingqueen-blstm-nnhmm-6 CaroleKingQueen26List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CaroleKingQueen - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-kingqueen-mlp-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-kingqueen-mlp-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-kingqueen-mlp-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-kingqueen-mlp-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-kingqueen-mlp-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-kingqueen-mlp-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-kingqueen-dbn-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-kingqueen-dbn-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-kingqueen-dbn-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-kingqueen-dbn-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-kingqueen-dbn-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-kingqueen-dbn-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-kingqueen-lstm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-kingqueen-lstm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-kingqueen-lstm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-kingqueen-lstm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-kingqueen-lstm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-kingqueen-lstm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-kingqueen-blstm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-kingqueen-blstm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-kingqueen-blstm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-kingqueen-blstm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-kingqueen-blstm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-kingqueen-blstm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-J6seg-ch-inv-1.pkl');evaluateCP J-kingqueen-knn-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-J6seg-ch-inv-2.pkl');evaluateCP J-kingqueen-knn-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knn-J6seg-ch-inv-3.pkl');evaluateCP J-kingqueen-knn-3 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-J6seg-ch-inv-1.pkl');evaluateCP J-kingqueen-svm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-J6seg-ch-inv-2.pkl');evaluateCP J-kingqueen-svm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svm-J6seg-ch-inv-3.pkl');evaluateCP J-kingqueen-svm-3 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mlpJ6segInvList.txt');evaluateCP J-kingqueen-mlp-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','dbnJ6segInvList.txt');evaluateCP J-kingqueen-dbn-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','lstmJ6segInvList.txt');evaluateCP J-kingqueen-lstm-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','blstmJ6segInvList.txt');evaluateCP J-kingqueen-blstm-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','knnJ6segInvList.txt');evaluateCP J-kingqueen-knn-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','svmJ6segInvList.txt');evaluateCP J-kingqueen-svm-ens CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','mixJ6segInvList.txt');evaluateCP J-kingqueen-mix-ens CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','2','CaroleKingQueen26ListBUB.mat','allJ6segInvList.txt');evaluateCP J-kingqueen-all-ens CaroleKingQueen26List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CaroleKingQueen - NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-kingqueen-mlp-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-kingqueen-mlp-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-kingqueen-mlp-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-kingqueen-mlp-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-kingqueen-mlp-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-kingqueen-mlp-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-kingqueen-dbn-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-kingqueen-dbn-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-kingqueen-dbn-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-kingqueen-dbn-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-kingqueen-dbn-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-kingqueen-dbn-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-kingqueen-lstm-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-kingqueen-lstm-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-kingqueen-lstm-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-kingqueen-lstm-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-kingqueen-lstm-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-kingqueen-lstm-nnhmm-6 CaroleKingQueen26List.txt;
% 
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-kingqueen-blstm-nnhmm-1 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-kingqueen-blstm-nnhmm-2 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-kingqueen-blstm-nnhmm-3 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-kingqueen-blstm-nnhmm-4 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-kingqueen-blstm-nnhmm-5 CaroleKingQueen26List.txt;
% tangkkace('SB','CaroleKingQueen26List.txt','1','CaroleKingQueen26ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-kingqueen-blstm-nnhmm-6 CaroleKingQueen26List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBeatles - INV %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-thebeatles-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-thebeatles-mlp-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-thebeatles-mlp-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-thebeatles-mlp-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-thebeatles-mlp-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-thebeatles-mlp-6 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-thebeatles-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-thebeatles-dbn-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-thebeatles-dbn-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-thebeatles-dbn-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-thebeatles-dbn-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-thebeatles-dbn-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-thebeatles-lstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-thebeatles-lstm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-thebeatles-lstm-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-thebeatles-lstm-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-thebeatles-lstm-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-thebeatles-lstm-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-thebeatles-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-thebeatles-blstm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-thebeatles-blstm-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-thebeatles-blstm-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-thebeatles-blstm-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-thebeatles-blstm-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','knn-J6seg-ch-inv-1.pkl');evaluateCP J-thebeatles-knn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','knn-J6seg-ch-inv-2.pkl');evaluateCP J-thebeatles-knn-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','knn-J6seg-ch-inv-3.pkl');evaluateCP J-thebeatles-knn-3 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','svm-J6seg-ch-inv-1.pkl');evaluateCP J-thebeatles-svm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','svm-J6seg-ch-inv-2.pkl');evaluateCP J-thebeatles-svm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','svm-J6seg-ch-inv-3.pkl');evaluateCP J-thebeatles-svm-3 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlpJ6segInvList.txt');evaluateCP J-thebeatles-mlp-ens TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbnJ6segInvList.txt');evaluateCP J-thebeatles-dbn-ens TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','lstmJ6segInvList.txt');evaluateCP J-thebeatles-lstm-ens TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstmJ6segInvList.txt');evaluateCP J-thebeatles-blstm-ens TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','knnJ6segInvList.txt');evaluateCP J-thebeatles-knn-ens TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','svmJ6segInvList.txt');evaluateCP J-thebeatles-svm-ens TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mixJ6segInvList.txt');evaluateCP J-thebeatles-mix-ens TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','allJ6segInvList.txt');evaluateCP J-thebeatles-all-ens TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBeatles - NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-thebeatles-mlp-nnhmm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-thebeatles-mlp-nnhmm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-thebeatles-mlp-nnhmm-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-thebeatles-mlp-nnhmm-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-thebeatles-mlp-nnhmm-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','mlp-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-thebeatles-mlp-nnhmm-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-1.pkl');evaluateCP J-thebeatles-dbn-nnhmm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-2.pkl');evaluateCP J-thebeatles-dbn-nnhmm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-3.pkl');evaluateCP J-thebeatles-dbn-nnhmm-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-4.pkl');evaluateCP J-thebeatles-dbn-nnhmm-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-5.pkl');evaluateCP J-thebeatles-dbn-nnhmm-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','dbn-J6seg-ch-inv-[500,500]-6.pkl');evaluateCP J-thebeatles-dbn-nnhmm-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-thebeatles-lstm-nnhmm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-thebeatles-lstm-nnhmm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-thebeatles-lstm-nnhmm-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-thebeatles-lstm-nnhmm-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-thebeatles-lstm-nnhmm-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','lstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-thebeatles-lstm-nnhmm-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-1.npz');evaluateCP J-thebeatles-blstm-nnhmm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-2.npz');evaluateCP J-thebeatles-blstm-nnhmm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-3.npz');evaluateCP J-thebeatles-blstm-nnhmm-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-4.npz');evaluateCP J-thebeatles-blstm-nnhmm-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-5.npz');evaluateCP J-thebeatles-blstm-nnhmm-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','1','TheBeatles180ListBUB.mat','blstm-J6seg-ch-inv-[500]-6.npz');evaluateCP J-thebeatles-blstm-nnhmm-6 TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CNPop - ch-SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CNPop20List.txt','3','CNPop20ListBUB.mat','blstmrnn-Jsong-ch-inv-i.npz');evaluateCP cnpop-blstmrnn CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','3','CNPop20ListBUB.mat','lstmrnn-Jsong-ch-inv-i.npz');evaluateCP cnpop-lstmrnn CNPop20List.txt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBeatles - ch-SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-Jsong-ch-inv-i.npz');evaluateCP thebeatles-blstmrnn TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','lstmrnn-Jsong-ch-inv-i.npz');evaluateCP thebeatles-lstmrnn TheBeatles180List.txt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CNPop - ns-SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CNPop20List.txt','4','CNPop20ListBUBns.mat','lstmrnn-Jsong-ns-inv-i.npz');evaluateCP cnpop-ns-lstmrnn CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','4','CNPop20ListBUBns.mat','blstmrnn-Jsong-ns-inv-i.npz');evaluateCP cnpop-ns-blstmrnn CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','4','CNPop20ListBUBns.mat','lstmrnn-Jsong-ns-inv-ii.npz');evaluateCP cnpop-ns-lstmrnnsg CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','4','CNPop20ListBUBns.mat','blstmrnn-Jsong-ns-inv-ii.npz');evaluateCP cnpop-ns-blstmrnnsg CNPop20List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBealtes - ns-SongNN %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','lstmrnn-Jsong-ns-inv-i.npz');evaluateCP thebeatles-ns-lstmrnn TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','blstmrnn-Jsong-ns-inv-i.npz');evaluateCP thebeatles-ns-blstmrnn TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','lstmrnn-Jsong-ns-inv-ii.npz');evaluateCP thebeatles-ns-lstmrnnsg TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','blstmrnn-Jsong-ns-inv-ii.npz');evaluateCP thebeatles-ns-blstmrnnsg TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-Jsong-ch-no7-i.npz');evaluateCP thebeatles-ch-blstmrnn-no7 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','blstmrnn-Jsong-ns-no7-i.npz');evaluateCP thebeatles-ns-blstmrnn-no7 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-Jsong-ch-noinv-i.npz');evaluateCP thebeatles-ch-blstmrnn-noinv TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','blstmrnn-Jsong-ns-noinv-i.npz');evaluateCP thebeatles-ns-blstmrnn-noinv TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CNPop - ns-NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-1.pkl');evaluateCP cnpop-ns-mlp-nnhmm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-2.pkl');evaluateCP cnpop-ns-mlp-nnhmm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-3.pkl');evaluateCP cnpop-ns-mlp-nnhmm-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-4.pkl');evaluateCP cnpop-ns-mlp-nnhmm-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP cnpop-ns-mlp-nnhmm-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-6.pkl');evaluateCP cnpop-ns-mlp-nnhmm-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-1.pkl');evaluateCP cnpop-ns-dbn-nnhmm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-2.pkl');evaluateCP cnpop-ns-dbn-nnhmm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-3.pkl');evaluateCP cnpop-ns-dbn-nnhmm-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-4.pkl');evaluateCP cnpop-ns-dbn-nnhmm-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP cnpop-ns-dbn-nnhmm-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-6.pkl');evaluateCP cnpop-ns-dbn-nnhmm-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','lstm-J6seg-ns-inv-[800]-1.npz');evaluateCP cnpop-ns-lstm-nnhmm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','lstm-J6seg-ns-inv-[800]-2.npz');evaluateCP cnpop-ns-lstm-nnhmm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','blstm-J6seg-ns-inv-[800]-1.npz');evaluateCP cnpop-ns-blstm-nnhmm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','5','CNPop20ListBUB','blstm-J6seg-ns-inv-[800]-2.npz');evaluateCP cnpop-ns-blstm-nnhmm-2 CNPop20List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-CNPop - ns-seg-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-1.pkl');evaluateCP cnpop-ns-mlp-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-2.pkl');evaluateCP cnpop-ns-mlp-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-3.pkl');evaluateCP cnpop-ns-mlp-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-4.pkl');evaluateCP cnpop-ns-mlp-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP cnpop-ns-mlp-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','mlp-J6seg-ns-inv-[800,800]-6.pkl');evaluateCP cnpop-ns-mlp-6 CNPop20List.txt;
% 
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-1.pkl');evaluateCP cnpop-ns-dbn-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-2.pkl');evaluateCP cnpop-ns-dbn-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-3.pkl');evaluateCP cnpop-ns-dbn-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-4.pkl');evaluateCP cnpop-ns-dbn-4 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP cnpop-ns-dbn-5 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','dbn-J6seg-ns-inv-[800,800]-6.pkl');evaluateCP cnpop-ns-dbn-6 CNPop20List.txt;

% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','knn-J6seg-ns-inv-1.pkl');evaluateCP cnpop-ns-knn-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','knn-J6seg-ns-inv-2.pkl');evaluateCP cnpop-ns-knn-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','knn-J6seg-ns-inv-3.pkl');evaluateCP cnpop-ns-knn-3 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','svm-J6seg-ns-inv-1.pkl');evaluateCP cnpop-ns-svm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','svm-J6seg-ns-inv-2.pkl');evaluateCP cnpop-ns-svm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','svm-J6seg-ns-inv-3.pkl');evaluateCP cnpop-ns-svm-3 CNPop20List.txt;

% 
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','lstm-J6seg-ns-inv-[800]-1.npz');evaluateCP cnpop-ns-lstm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','lstm-J6seg-ns-inv-[800]-2.npz');evaluateCP cnpop-ns-lstm-2 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','blstm-J6seg-ns-inv-[800]-1.npz');evaluateCP cnpop-ns-blstm-1 CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','6','CNPop20ListBUB','blstm-J6seg-ns-inv-[800]-2.npz');evaluateCP cnpop-ns-blstm-2 CNPop20List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBealtes - ns-NN-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-1.pkl');evaluateCP thebeatles-ns-mlp-nnhmm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-2.pkl');evaluateCP thebeatles-ns-mlp-nnhmm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-3.pkl');evaluateCP thebeatles-ns-mlp-nnhmm-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-4.pkl');evaluateCP thebeatles-ns-mlp-nnhmm-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP thebeatles-ns-mlp-nnhmm-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-6.pkl');evaluateCP thebeatles-ns-mlp-nnhmm-6 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-1.pkl');evaluateCP thebeatles-ns-dbn-nnhmm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-2.pkl');evaluateCP thebeatles-ns-dbn-nnhmm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-3.pkl');evaluateCP thebeatles-ns-dbn-nnhmm-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-4.pkl');evaluateCP thebeatles-ns-dbn-nnhmm-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP thebeatles-ns-dbn-nnhmm-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-6.pkl');evaluateCP thebeatles-ns-dbn-nnhmm-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','lstm-J6seg-ns-inv-[800]-1.npz');evaluateCP thebeatles-ns-lstm-nnhmm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','lstm-J6seg-ns-inv-[800]-2.npz');evaluateCP thebeatles-ns-lstm-nnhmm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','blstm-J6seg-ns-inv-[800]-1.npz');evaluateCP thebeatles-ns-blstm-nnhmm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','5','TheBeatles180ListBUB','blstm-J6seg-ns-inv-[800]-2.npz');evaluateCP thebeatles-ns-blstm-nnhmm-2 TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% J-TheBealtes - ns-seg-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-1.pkl');evaluateCP thebeatles-ns-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-2.pkl');evaluateCP thebeatles-ns-mlp-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-3.pkl');evaluateCP thebeatles-ns-mlp-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-4.pkl');evaluateCP thebeatles-ns-mlp-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP thebeatles-ns-mlp-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-J6seg-ns-inv-[800,800]-6.pkl');evaluateCP thebeatles-ns-mlp-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-1.pkl');evaluateCP thebeatles-ns-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-2.pkl');evaluateCP thebeatles-ns-dbn-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-3.pkl');evaluateCP thebeatles-ns-dbn-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-4.pkl');evaluateCP thebeatles-ns-dbn-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP thebeatles-ns-dbn-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-J6seg-ns-inv-[800,800]-6.pkl');evaluateCP thebeatles-ns-dbn-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','knn-J6seg-ns-inv-1.pkl');evaluateCP thebeatles-ns-knn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','knn-J6seg-ns-inv-2.pkl');evaluateCP thebeatles-ns-knn-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','knn-J6seg-ns-inv-3.pkl');evaluateCP thebeatles-ns-knn-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','svm-J6seg-ns-inv-1.pkl');evaluateCP thebeatles-ns-svm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','svm-J6seg-ns-inv-2.pkl');evaluateCP thebeatles-ns-svm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','svm-J6seg-ns-inv-3.pkl');evaluateCP thebeatles-ns-svm-3 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','lstm-J6seg-ns-inv-[800]-1.npz');evaluateCP thebeatles-ns-lstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','lstm-J6seg-ns-inv-[800]-2.npz');evaluateCP thebeatles-ns-lstm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-J6seg-ns-inv-[800]-1.npz');evaluateCP thebeatles-ns-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-J6seg-ns-inv-[800]-2.npz');evaluateCP thebeatles-ns-blstm-2 TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% CJ-TheBealtes - ns-seg-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJ-thebeatles-ns-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[800,800]-2.pkl');evaluateCP CJ-thebeatles-ns-mlp-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[800,800]-3.pkl');evaluateCP CJ-thebeatles-ns-mlp-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[800,800]-4.pkl');evaluateCP CJ-thebeatles-ns-mlp-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[800,800]-5.pkl');evaluateCP CJ-thebeatles-ns-mlp-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[800,800]-6.pkl');evaluateCP CJ-thebeatles-ns-mlp-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJ-thebeatles-ns-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800]-2.pkl');evaluateCP CJ-thebeatles-ns-dbn-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800]-3.pkl');evaluateCP CJ-thebeatles-ns-dbn-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800]-4.pkl');evaluateCP CJ-thebeatles-ns-dbn-4 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800]-5.pkl');evaluateCP CJ-thebeatles-ns-dbn-5 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800]-6.pkl');evaluateCP CJ-thebeatles-ns-dbn-6 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,144,500]-1.pkl');evaluateCP CJ-thebeatles-ns-dbn-7 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,144,800]-1.pkl');evaluateCP CJ-thebeatles-ns-dbn-8 TheBeatles180List.txt;
%
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','svm-CJ6seg-ns-inv-1.pkl');evaluateCP CJ-thebeatles-ns-svm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','svm-CJ6seg-ns-inv-2.pkl');evaluateCP CJ-thebeatles-ns-svm-2 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','lstm-CJ6seg-ns-inv-[800]-1.npz');evaluateCP CJ-thebeatles-ns-lstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','lstm-CJ6seg-ns-inv-[800]-2.npz');evaluateCP CJ-thebeatles-ns-lstm-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJ6seg-ns-inv-[800]-1.npz');evaluateCP CJ-thebeatles-ns-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJ6seg-ns-inv-[800]-2.npz');evaluateCP CJ-thebeatles-ns-blstm-2 TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% CJK-TheBealtes - ns-seg-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[800,800]-1_.pkl');evaluateCP CJK-thebeatles-ns-mlp-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[800,800]-2_.pkl');evaluateCP CJK-thebeatles-ns-mlp-2_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[800,800]-3_.pkl');evaluateCP CJK-thebeatles-ns-mlp-3_ TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800]-1_.pkl');evaluateCP CJK-thebeatles-ns-dbn-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800]-2_.pkl');evaluateCP CJK-thebeatles-ns-dbn-2_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800]-3_.pkl');evaluateCP CJK-thebeatles-ns-dbn-3_ TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJK-thebeatles-ns-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[800,800]-2.pkl');evaluateCP CJK-thebeatles-ns-mlp-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[800,800]-3.pkl');evaluateCP CJK-thebeatles-ns-mlp-3 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJK-thebeatles-ns-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800]-2.pkl');evaluateCP CJK-thebeatles-ns-dbn-2 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800]-3.pkl');evaluateCP CJK-thebeatles-ns-dbn-3 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800]-6.pkl');evaluateCP CJK-thebeatles-ns-dbn-6 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','svm-CJK6seg-ns-inv-1.pkl');evaluateCP CJK-thebeatles-ns-svm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','svm-CJK6seg-ns-inv-2.pkl');evaluateCP CJK-thebeatles-ns-svm-2 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','lstm-CJK6seg-ns-inv-[800]-1.npz');evaluateCP CJK-thebeatles-ns-lstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','lstm-CJK6seg-ns-inv-[800]-2.npz');evaluateCP CJK-thebeatles-ns-lstm-2 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJK6seg-ns-inv-[800]-1.npz');evaluateCP CJK-thebeatles-ns-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJK6seg-ns-inv-[800]-2.npz');evaluateCP CJK-thebeatles-ns-blstm-2 TheBeatles180List.txt;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Jazz Region %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Gaussian-HMM Baseline %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('JazzBaseline','GaryBurton7List.txt','0','0','0');evaluateJazz garyburton-baseline GaryBurton7List.txt;
% tangkkace('JazzBaseline','JG106List.txt','0','0','0');evaluateJazz jg106-baseline JG106List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Jazz - ch-seg-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('Jazz','GaryBurton7List.txt','2','GaryBurton7ListBUB.mat','mlp-Jazz6seg-ch-jazz-[500,500]-1.pkl');evaluateJazz garyburton-mlp-1 GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','2','GaryBurton7ListBUB.mat','mlp-Jazz6seg-ch-jazz-[500,500]-2.pkl');evaluateJazz garyburton-mlp-2 GaryBurton7List.txt;
% 
% tangkkace('Jazz','GaryBurton7List.txt','2','GaryBurton7ListBUB.mat','dbn-Jazz6seg-ch-jazz-[500,500]-1.pkl');evaluateJazz garyburton-dbn-1 GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','2','GaryBurton7ListBUB.mat','dbn-Jazz6seg-ch-jazz-[500,500]-2.pkl');evaluateJazz garyburton-dbn-2 GaryBurton7List.txt;
% 
% tangkkace('Jazz','GaryBurton7List.txt','2','GaryBurton7ListBUB.mat','blstm-Jazz6seg-ch-jazz-[500]-1.npz');evaluateJazz garyburton-blstm-1 GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','2','GaryBurton7ListBUB.mat','blstm-Jazz6seg-ch-jazz-[500]-2.npz');evaluateJazz garyburton-blstm-2 GaryBurton7List.txt;
% 
% tangkkace('Jazz','GaryBurton7List.txt','2','GaryBurton7ListBUB.mat','svm-Jazz6seg-ch-jazz-1.pkl');evaluateJazz garyburton-svm-1 GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','2','GaryBurton7ListBUB.mat','svm-Jazz6seg-ch-jazz-2.pkl');evaluateJazz garyburton-svm-2 GaryBurton7List.txt;

% tangkkace('JazzAll','JG106List.txt','2','JG106ListBUB.mat','mlp-JazzTutorial6seg-ch-jazzall-[800,800]-1.pkl');evaluateJazzAll jg106-ch-mlp-1 JG106List.txt;
% tangkkace('JazzAll','JG106List.txt','2','JG106ListBUB.mat','dbn-JazzTutorial6seg-ch-jazzall-[800,800]-1.pkl');evaluateJazzAll jg106-ch-dbn-1 JG106List.txt;
% tangkkace('JazzAll','JG106List.txt','2','JG106ListBUB.mat','blstm-JazzTutorial6seg-ch-jazzall-[800]-1.npz');evaluateJazzAll jg106-ch-blstm-1 JG106List.txt;

% tangkkace('Jazz','JG106List.txt','2','JG106ListBUB.mat','mlp-JazzTutorial6seg-ch-jazz-[800,800]-1.pkl');evaluateJazz jg106-ch-mlp-1 JG106List.txt;
% tangkkace('Jazz','JG106List.txt','2','JG106ListBUB.mat','dbn-JazzTutorial6seg-ch-jazz-[800,800]-1.pkl');evaluateJazz jg106-ch-dbn-1 JG106List.txt;
% tangkkace('Jazz','JG106List.txt','2','JG106ListBUB.mat','blstm-JazzTutorial6seg-ch-jazz-[800]-1.npz');evaluateJazz jg106-ch-blstm-1 JG106List.txt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Jazz - ns-seg-HMM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('Jazz','GaryBurton7List.txt','6','GaryBurton7ListBUB','mlp-Jazz6seg-ns-jazz-[800,800]-1.pkl');evaluateJazz garyburton-ns-mlp-1 GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','6','GaryBurton7ListBUB','mlp-Jazz6seg-ns-jazz-[800,800]-2.pkl');evaluateJazz garyburton-ns-mlp-2 GaryBurton7List.txt;
% 
% tangkkace('Jazz','GaryBurton7List.txt','6','GaryBurton7ListBUB','dbn-Jazz6seg-ns-jazz-[800,800]-1.pkl');evaluateJazz garyburton-ns-dbn-1 GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','6','GaryBurton7ListBUB','dbn-Jazz6seg-ns-jazz-[800,800]-2.pkl');evaluateJazz garyburton-ns-dbn-2 GaryBurton7List.txt;
% 
% tangkkace('Jazz','GaryBurton7List.txt','6','GaryBurton7ListBUB','blstm-Jazz6seg-ns-jazz-[800]-1.npz');evaluateJazz garyburton-ns-blstm-1 GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','6','GaryBurton7ListBUB','blstm-Jazz6seg-ns-jazz-[800]-2.npz');evaluateJazz garyburton-ns-blstm-2 GaryBurton7List.txt;
% 
% tangkkace('Jazz','GaryBurton7List.txt','6','GaryBurton7ListBUB','svm-Jazz6seg-ns-jazz-1.pkl');evaluateJazz garyburton-ns-svm-1 GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','6','GaryBurton7ListBUB','svm-Jazz6seg-ns-jazz-2.pkl');evaluateJazz garyburton-ns-svm-2 GaryBurton7List.txt;

% tangkkace('JazzAll','JG106List.txt','6','JG106ListBUB','mlp-JazzTutorial6seg-ns-jazzall-[800,800]-1.pkl');evaluateJazzAll jg106-ns-mlp-1 JG106List.txt;
% tangkkace('JazzAll','JG106List.txt','6','JG106ListBUB','dbn-JazzTutorial6seg-ns-jazzall-[800,800]-1.pkl');evaluateJazzAll jg106-ns-dbn-1 JG106List.txt;
% tangkkace('JazzAll','JG106List.txt','6','JG106ListBUB','blstm-JazzTutorial6seg-ns-jazzall-[800]-1.npz');evaluateJazzAll jg106-ns-blstm-1 JG106List.txt;

% tangkkace('Jazz','JG106List.txt','6','JG106ListBUB','mlp-JazzTutorial6seg-ns-jazz-[800,800]-1.pkl');evaluateJazz jg106-ns-mlp-1 JG106List.txt;
% tangkkace('Jazz','JG106List.txt','6','JG106ListBUB','dbn-JazzTutorial6seg-ns-jazz-[800,800]-1.pkl');evaluateJazz jg106-ns-dbn-1 JG106List.txt;
% tangkkace('Jazz','JG106List.txt','6','JG106ListBUB','blstm-JazzTutorial6seg-ns-jazz-[800]-1.npz');evaluateJazz jg106-ns-blstm-1 JG106List.txt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Jazz - ch-songwise %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('Jazz','GaryBurton7List.txt','3','GaryBurton7ListBUB.mat','lstmrnn-Jazzsong-ch-jazz-i.npz');evaluateJazz garyburton-lstmrnn GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','3','GaryBurton7ListBUB.mat','blstmrnn-Jazzsong-ch-jazz-i.npz');evaluateJazz garyburton-blstmrnn GaryBurton7List.txt;
% tangkkace('Jazz','JG106List.txt','3','JG106ListBUB.mat','blstmrnn-JazzTutorialsong-ch-jazz-[800]-1.npz');evaluateJazz jg106-ch-blstmrnn JG106List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Jazz - ns-songwise %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('Jazz','GaryBurton7List.txt','4','GaryBurton7ListBUBns.mat','lstmrnn-Jazzsong-ns-jazz-i.npz');evaluateJazz garyburton-ns-lstmrnn GaryBurton7List.txt;
% tangkkace('Jazz','GaryBurton7List.txt','4','GaryBurton7ListBUBns.mat','blstmrnn-Jazzsong-ns-jazz-i.npz');evaluateJazz garyburton-ns-blstmrnn GaryBurton7List.txt;
% tangkkace('Jazz','JG106List.txt','4','JG106ListBUBns.mat','blstmrnn-JazzTutorialsong-ns-jazz-[800]-1.npz');evaluateJazz jg106-ns-blstmrnn JG106List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Full (121) Region %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('Full','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','mlp-CJKUR6seg-ch-full-[800,800]-1.pkl');evaluateFull thebeatles-mlp-CJKUR6seg-ch-full-[800,800]-1 TheBeatles180List.txt;
% tangkkace('Full','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','dbn-CJKUR6seg-ch-full-[800,800]-1.pkl');evaluateFull thebeatles-dbn-CJKUR6seg-ch-full-[800,800]-1 TheBeatles180List.txt;
% tangkkace('Full','TheBeatles180List.txt','2','TheBeatles180ListBUB.mat','blstm-CJKUR6seg-ch-full-[800]-1.npz');evaluateFull thebeatles-blstm-CJKUR6seg-ch-full-[800]-1 TheBeatles180List.txt;

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
%%%%%%%%%%%%%%%%%% Simple Test (Examples running)%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% baseline approach - chordino like:
% tangkkace('Chordino','tempList.txt','0','0','0');evaluateCP tempList tempList.txt;

% non-baseline:
% tangkkace('SB','tempList.txt','-1','tempListBUB.mat',0);
% tangkkace('SB','tempList.txt','3','tempListBUB.mat','blstmrnn-Jsong-ch-no7-i.npz');evaluateCP temp-ch-blstmrnn-no7 tempList.txt;
% tangkkace('SB','tempList.txt','-2','tempListBUBns.mat',0);
% tangkkace('SB','tempList.txt','4','tempListBUBns.mat','blstmrnn-Jsong-ns-no7-i.npz');evaluateCP temp-ns-blstmrnn-no7 tempList.txt;
% tangkkace('SB','tempList.txt','5','tempListBUB','mlp-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP temp-test tempList.txt;
% tangkkace('SB','tempList.txt','6','tempListBUB','mlp-J6seg-ns-inv-[800,800]-5.pkl');evaluateCP temp-test tempList.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Further Runs Song Model%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ch runs
% tangkkace('SB','CNPop20List.txt','3','CNPop20ListBUB.mat','ctc-Jsong-ch-inv-i.npz');evaluateCP cnpop-ctc-temp-i CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','3','CNPop20ListBUB.mat','ctc-Jsong-ch-inv-ii.npz');evaluateCP cnpop-ctc-temp-ii CNPop20List.txt;
% tangkkace('SB','CNPop20List.txt','3','CNPop20ListBUB.mat','ctc-Jsong-ch-inv-iii.npz');evaluateCP cnpop-ctc-temp-iii CNPop20List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','ctc-Jsong-ch-inv-i.npz');evaluateCP thebeatles-ctc-temp-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','ctc-Jsong-ch-inv-ii.npz');evaluateCP thebeatles-ctc-temp-ii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','ctc-CJKsong-ch-inv-i.npz');evaluateCP thebeatles-ctc-ch-CJK-temp-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','ctc-CJKUsong-ch-inv-i.npz');evaluateCP thebeatles-ctc-ch-CJKU-temp-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','bctc-CJKsong-ch-inv-i.npz');evaluateCP thebeatles-bctc-ch-CJK-temp-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','bctc-CJKUsong-ch-inv-i.npz');evaluateCP thebeatles-bctc-ch-CJKU-temp-i TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-Jsong-ch-inv-i.npz');evaluateCP thebeatles-blstm-ch-J-temp-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJsong-ch-inv-i.npz');evaluateCP thebeatles-blstm-ch-CJ-temp-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKsong-ch-inv-i.npz');evaluateCP thebeatles-blstm-ch-CJK-temp-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKUsong-ch-inv-i.npz');evaluateCP thebeatles-blstm-ch-CJKU-temp-i TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800]-1.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800]-1_.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800]-1_ TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800,800]-1-sg.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800,800]-1-sg TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800,800]-1_-sg.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800,800]-1_-sg TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800,800]-1__-sg.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800,800]-1__-sg TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800,800]-1___-sg.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800,800]-1___-sg TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-Jsong-ch-inv-[800]-1.npz');evaluateCP thebeatles-blstmrnn_ec-Jsong-ch-inv-[800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-Jsong-ch-inv-[800]-1_.npz');evaluateCP thebeatles-blstmrnn_ec-Jsong-ch-inv-[800]-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-Jsong-ch-inv-[800]-1__.npz');evaluateCP thebeatles-blstmrnn_ec-Jsong-ch-inv-[800]-1__ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-Jsong-ch-inv-[800]-1___.npz');evaluateCP thebeatles-blstmrnn_ec-Jsong-ch-inv-[800]-1___ TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJsong-ch-inv-[800]-1.npz');evaluateCP thebeatles-blstmrnn_ec-CJsong-ch-inv-[800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJsong-ch-inv-[800]-1_.npz');evaluateCP thebeatles-blstmrnn_ec-CJsong-ch-inv-[800]-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJsong-ch-inv-[800]-1__.npz');evaluateCP thebeatles-blstmrnn_ec-CJsong-ch-inv-[800]-1__ TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKsong-ch-inv-[800]-1.npz');evaluateCP thebeatles-blstmrnn_ec-CJKsong-ch-inv-[800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKsong-ch-inv-[800]-1_.npz');evaluateCP thebeatles-blstmrnn_ec-CJKsong-ch-inv-[800]-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKsong-ch-inv-[800]-1__.npz');evaluateCP thebeatles-blstmrnn_ec-CJKsong-ch-inv-[800]-1__ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKsong-ch-inv-[800]-1___.npz');evaluateCP thebeatles-blstmrnn_ec-CJKsong-ch-inv-[800]-1___ TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKUsong-ch-inv-[800]-1.npz');evaluateCP thebeatles-blstmrnn_ec-CJKUsong-ch-inv-[800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKUsong-ch-inv-[800]-1_.npz');evaluateCP thebeatles-blstmrnn_ec-CJKUsong-ch-inv-[800]-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKUsong-ch-inv-[800]-1__.npz');evaluateCP thebeatles-blstmrnn_ec-CJKUsong-ch-inv-[800]-1__ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKUsong-ch-inv-[800]-1___.npz');evaluateCP thebeatles-blstmrnn_ec-CJKUsong-ch-inv-[800]-1___ TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKURsong-ch-inv-[800]-1.npz');evaluateCP thebeatles-blstmrnn_ec-CJKURsong-ch-inv-[800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKURsong-ch-inv-[800]-1_.npz');evaluateCP thebeatles-blstmrnn_ec-CJKURsong-ch-inv-[800]-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKURsong-ch-inv-[800]-1__.npz');evaluateCP thebeatles-blstmrnn_ec-CJKURsong-ch-inv-[800]-1__ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn_ec-CJKURsong-ch-inv-[800]-1___.npz');evaluateCP thebeatles-blstmrnn_ec-CJKURsong-ch-inv-[800]-1___ TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800]-1.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800]-1_.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800]-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800]-1__.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800]-1__ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','3','TheBeatles180ListBUB.mat','blstmrnn-CJKURsong-ch-inv-[800]-1___.npz');evaluateCP thebeatles-blstmrnn-CJKURsong-ch-inv-[800]-1___ TheBeatles180List.txt;


% ns runs
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','blstmrnn-CJsong-ns-inv-i.npz');evaluateCP thebeatles-blstm-ns-CJ-temp-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','blstmrnn-CJKsong-ns-inv-ii.npz');evaluateCP thebeatles-blstm-ns-CJK-temp-ii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','blstmrnn-CJsong-ns-inv-ii.npz');evaluateCP thebeatles-blstm-ns-CJ-temp-ii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','blstmrnn-CJKsong-ns-inv-i.npz');evaluateCP thebeatles-blstm-ns-CJK-temp-i TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','4','TheBeatles180ListBUBns.mat','bctc-CJKsong-ns-inv-i.npz');evaluateCP thebeatles-bctc-ns-CJK-temp-i TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Further Runs 6seg ns Model%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJKU(191)6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-thebeatles-ns-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJKU(191)6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-thebeatles-ns-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJKU(191)6seg-ns-inv-[800]-1.npz');evaluateCP CJKU(191)-thebeatles-ns-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJKU(191)6seg-ns-inv-[800]-1_.npz');evaluateCP CJKU(191)-thebeatles-ns-blstm-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJKU(191)6seg-ns-inv-[800]-1__.npz');evaluateCP CJKU(191)-thebeatles-ns-blstm-1__ TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJKU6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJKU-thebeatles-ns-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJKU6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJKU-thebeatles-ns-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJKU6seg-ns-inv-[800]-1.npz');evaluateCP CJKU-thebeatles-ns-blstm-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJKUR6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJKUR-thebeatles-ns-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJKUR6seg-ns-inv-[800,800]-1.pkl');evaluateCP CJKUR-thebeatles-ns-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJKUR6seg-ns-inv-[800]-1.npz');evaluateCP CJKUR-thebeatles-ns-blstm-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJKUR6seg-ns-Mm-[800,800]-1.pkl');evaluateCP thebeatles-mlp-CJKUR6seg-ns-Mm-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJKUR6seg-ns-Mm-[800,800]-1.pkl');evaluateCP thebeatles-dbn-CJKUR6seg-ns-Mm-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJKUR6seg-ns-Mm-[800]-1_.npz');evaluateCP thebeatles-blstm-CJKUR6seg-ns-Mm-[800]-1_ TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','blstm-CJKUR6seg-ns-Mm-[800]-1.npz');evaluateCP thebeatles-blstm-CJKUR6seg-ns-Mm-[800]-1 TheBeatles180List.txt;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Further Runs 6seg ch Model%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp_bc-CJ6seg-ch-inv-[800,800]-1.pkl');evaluateCP thebeatles-mlp_bc-CJ6seg-ch-inv-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn_bc-CJ6seg-ch-inv-[800,800]-1.pkl');evaluateCP thebeatles-dbn_bc-CJ6seg-ch-inv-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm_bc-CJ6seg-ch-inv-[800]-1.npz');evaluateCP blstm_bc-CJ6seg-ch-inv-[800]-1 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp_bc-CJK6seg-ch-inv-[800,800]-1.pkl');evaluateCP thebeatles-mlp_bc-CJK6seg-ch-inv-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn_bc-CJK6seg-ch-inv-[800,800]-1.pkl');evaluateCP thebeatles-dbn_bc-CJK6seg-ch-inv-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm_bc-CJK6seg-ch-inv-[800]-1.npz');evaluateCP blstm_bc-CJK6seg-ch-inv-[800]-1 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp_bc-CJKU6seg-ch-inv-[800,800]-1.pkl');evaluateCP thebeatles-mlp_bc-CJKU6seg-ch-inv-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn_bc-CJKU6seg-ch-inv-[800,800]-1.pkl');evaluateCP thebeatles-dbn_bc-CJKU6seg-ch-inv-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm_bc-CJKU6seg-ch-inv-[800]-1.npz');evaluateCP blstm_bc-CJKU6seg-ch-inv-[800]-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp_bc-CJKUR6seg-ch-inv-[800,800]-1.pkl');evaluateCP thebeatles-mlp_bc-CJKUR6seg-ch-inv-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn_bc-CJKUR6seg-ch-inv-[800,800]-1.pkl');evaluateCP thebeatles-dbn_bc2-CJKUR6seg-ch-inv-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm_bc-CJKUR6seg-ch-inv-[800]-1.npz');evaluateCP blstm_bc-CJKUR6seg-ch-inv-[800]-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJKUR6seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKUR-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKUR6seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKUR-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKUR6seg-ch-inv-[800]-1.npz');evaluateCP CJKUR-thebeatles-ch-blstm-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJKUR6seg-ch-Mm-[800,800]-1.pkl');evaluateCP thebeatles-mlp-CJKUR6seg-ch-Mm-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKUR6seg-ch-Mm-[800,800]-1.pkl');evaluateCP thebeatles-dbn-CJKUR6seg-ch-Mm-[800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKUR6seg-ch-Mm-[800]-1_.npz');evaluateCP thebeatles-blstm-CJKUR6seg-ch-Mm-[800]-1_ TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Further Runs 6seg ns Deeper Model%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[500,500,500,500,500]-i.pkl');evaluateCP dbn-CJ6seg-ns-inv-[500,500,500,500,500]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[500,500,500,500,500]-iiii.pkl');evaluateCP dbn-CJ6seg-ns-inv-[500,500,500,500,500]-iiii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[504,144,504]-i.pkl');evaluateCP dbn-CJ6seg-ns-inv-[504,144,504]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,504,144,504,800]-i.pkl');evaluateCP dbn-CJ6seg-ns-inv-[800,504,144,504,800]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800,800,800,800]-i.pkl');evaluateCP dbn-CJ6seg-ns-inv-[800,800,800,800,800]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800,800,800,800]-ii.pkl');evaluateCP dbn-CJ6seg-ns-inv-[800,800,800,800,800]-ii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800,800,800,800]-iii.pkl');evaluateCP dbn-CJ6seg-ns-inv-[800,800,800,800,800]-iii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[800,800,800,800,800]-iiii.pkl');evaluateCP dbn-CJ6seg-ns-inv-[800,800,800,800,800]-iiii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[1512,504,144,504,504,504]-ii.pkl');evaluateCP dbn-CJ6seg-ns-inv-[1512,504,144,504,504,504]-ii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[1512,504,144,504,504]-ii.pkl');evaluateCP dbn-CJ6seg-ns-inv-[1512,504,144,504,504]-ii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[1512,504,144,504]-i.pkl');evaluateCP dbn-CJ6seg-ns-inv-[1512,504,144,504]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[1512,504,144,504]-ii.pkl');evaluateCP dbn-CJ6seg-ns-inv-[1512,504,144,504]-ii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[1512,504,144,504]-iii.pkl');evaluateCP dbn-CJ6seg-ns-inv-[1512,504,144,504]-iii TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[1512,504,144]-i.pkl');evaluateCP dbn-CJ6seg-ns-inv-[1512,504,144]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJ6seg-ns-inv-[1512,800,504,144,504,504,504]-i.pkl');evaluateCP dbn-CJ6seg-ns-inv-[1512,800,504,144,504,504,504]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[504,144,504]-i.pkl');evaluateCP mlp-CJ6seg-ns-inv-[504,144,504]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[800,504,144,504,800]-i.pkl');evaluateCP mlp-CJ6seg-ns-inv-[800,504,144,504,800]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[1512,504,144,504]-i.pkl');evaluateCP mlp-CJ6seg-ns-inv-[1512,504,144,504]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJ6seg-ns-inv-[1512,504,144]-i.pkl');evaluateCP mlp-CJ6seg-ns-inv-[1512,504,144]-i TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[1000,1000]-1.pkl');evaluateCP mlp-CJK6seg-ns-inv-[1000,1000]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[2000,2000]-1.pkl');evaluateCP mlp-CJK6seg-ns-inv-[2000,2000]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[2000,2000,2000]-1.pkl');evaluateCP mlp-CJK6seg-ns-inv-[2000,2000,2000]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[3000,3000]-1.pkl');evaluateCP mlp-CJK6seg-ns-inv-[3000,3000]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','mlp-CJK6seg-ns-inv-[3000,3000,3000]-1.pkl');evaluateCP mlp-CJK6seg-ns-inv-[3000,3000,3000]-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[1000,1000]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[1000,1000]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[2000,2000]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[2000,2000]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[2000,2000,2000]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[2000,2000,2000]-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[500,500]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[500,500]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[500,500,500]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[500,500,500]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[500,500,500,500]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[500,500,500,500]-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[1000,1000,1000]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[1000,1000,1000]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800,800]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[800,800,800]-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','6','TheBeatles180ListBUB','dbn-CJK6seg-ns-inv-[800,800,800,800]-1.pkl');evaluateCP dbn-CJK6seg-ns-inv-[800,800,800,800]-1 TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Further Runs 6seg ch Deeper Model%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK6seg-ch-inv-[500,500]-i.pkl');evaluateCP dbn-CJK6seg-ch-inv-[500,500]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK6seg-ch-inv-[500,500,500]-i.pkl');evaluateCP dbn-CJK6seg-ch-inv-[500,500,500]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK6seg-ch-inv-[800,800,800]-i.pkl');evaluateCP dbn-CJK6seg-ch-inv-[800,800,800]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK6seg-ch-inv-[1000,1000,1000]-i.pkl');evaluateCP dbn-CJK6seg-ch-inv-[1000,1000,1000]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK6seg-ch-inv-[1000,1000]-i.pkl');evaluateCP dbn-CJK6seg-ch-inv-[1000,1000]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK6seg-ch-inv-[2000,2000]-i.pkl');evaluateCP dbn-CJK6seg-ch-inv-[2000,2000]-i TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)6seg-ch-inv-[500,500]-i.pkl');evaluateCP dbn-CJKU(191)6seg-ch-inv-[500,500]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)6seg-ch-inv-[1000,1000]-i.pkl');evaluateCP dbn-CJKU(191)6seg-ch-inv-[1000,1000]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)6seg-ch-inv-[2000,2000]-i.pkl');evaluateCP dbn-CJKU(191)6seg-ch-inv-[2000,2000]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)6seg-ch-inv-[3000,3000]-i.pkl');evaluateCP dbn-CJKU(191)6seg-ch-inv-[3000,3000]-i TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)6seg-ch-inv-[1000,1000,1000]-i.pkl');evaluateCP dbn-CJKU(191)6seg-ch-inv-[1000,1000,1000]-i TheBeatles180List.txt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Further Runs Xseg Model%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJK1seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-1seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJK2seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-2seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJK3seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-3seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJK6seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-6seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJK9seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-9seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJK12seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-12seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK1seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-1seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK2seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-2seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK3seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-3seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK6seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-6seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK9seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-9seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJK12seg-ch-inv-[800,800]-1.pkl');evaluateCP CJK-12seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJK1seg-ch-inv-[800]-1.npz');evaluateCP CJK-1seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJK2seg-ch-inv-[800]-1.npz');evaluateCP CJK-2seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJK3seg-ch-inv-[800]-1.npz');evaluateCP CJK-3seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJK6seg-ch-inv-[800]-1.npz');evaluateCP CJK-6seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJK9seg-ch-inv-[800]-1.npz');evaluateCP CJK-9seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJK12seg-ch-inv-[800]-1.npz');evaluateCP CJK-12seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;

% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJKU(191)1seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-1seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJKU(191)2seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-2seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJKU(191)3seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-3seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJKU(191)6seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-6seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJKU(191)9seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-9seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','mlp-CJKU(191)12seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-12seg-thebeatles-ch-mlp-1 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)1seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-1seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)2seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-2seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB ','dbn-CJKU(191)3seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-3seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)6seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-6seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)9seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-9seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','dbn-CJKU(191)12seg-ch-inv-[800,800]-1.pkl');evaluateCP CJKU(191)-12seg-thebeatles-ch-dbn-1 TheBeatles180List.txt;
% 
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKU(191)1seg-ch-inv-[800]-1.npz');evaluateCP CJKU(191)-1seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKU(191)2seg-ch-inv-[800]-1.npz');evaluateCP CJKU(191)-2seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKU(191)3seg-ch-inv-[800]-1.npz');evaluateCP CJKU(191)-3seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKU(191)6seg-ch-inv-[800]-1.npz');evaluateCP CJKU(191)-6seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKU(191)9seg-ch-inv-[800]-1.npz');evaluateCP CJKU(191)-9seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKU(191)12seg-ch-inv-[800]-1.npz');evaluateCP CJKU(191)-12seg-thebeatles-ch-blstm-1 TheBeatles180List.txt;
% tangkkace('SB','TheBeatles180List.txt','2','TheBeatles180ListBUB','blstm-CJKU(191)6seg-ch-inv-[800]-1_.npz');evaluateCP CJKU(191)-6seg-thebeatles-ch-blstm-1_ TheBeatles180List.txt;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CV Testing %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% now we only specify the dnn model, dataset, feature level, network config
% the evaluation will automatically run and generate the cv results
% this refactoring clearout a lot of previous redundancies
% tangkkace_cv('X-CJKURB-ch-6seg-X','put');
% tangkkace_cv('X-CJKURB-ns-6seg-X','put');

% tangkkace_cv('X-JKU-ch-1seg-X','put');
% tangkkace_cv('X-JKU-ns-1seg-X','put');
% tangkkace_cv('X-JKU-ch-2seg-X','put');
% tangkkace_cv('X-JKU-ns-2seg-X','put');
% tangkkace_cv('X-JKU-ch-3seg-X','put');
% tangkkace_cv('X-JKU-ns-3seg-X','put');
% tangkkace_cv('X-JKU-ch-9seg-X','put');
% tangkkace_cv('X-JKU-ns-9seg-X','put');
% tangkkace_cv('X-JKU-ch-12seg-X','put');
% tangkkace_cv('X-JKU-ns-12seg-X','put');

% massive cv testing - testing error

% *************************** segtile ******************************** %
% tangkkace_cv('mlp-JKU-ch-1seg-800,800','get');
% tangkkace_cv('mlp-JKU-ch-2seg-800,800','get');
% tangkkace_cv('mlp-JKU-ch-3seg-800,800','get');
% tangkkace_cv('mlp-JKU-ch-9seg-800,800','get');
% tangkkace_cv('mlp-JKU-ch-12seg-800,800','get');
% tangkkace_cv('mlp-JKU-ns-1seg-800,800','get');
% tangkkace_cv('mlp-JKU-ns-2seg-800,800','get');
% tangkkace_cv('mlp-JKU-ns-3seg-800,800','get');
% tangkkace_cv('mlp-JKU-ns-9seg-800,800','get');
% tangkkace_cv('mlp-JKU-ns-12seg-800,800','get');
% 
% tangkkace_cv('dbn-JKU-ch-1seg-800,800','get');
% tangkkace_cv('dbn-JKU-ch-2seg-800,800','get');
% tangkkace_cv('dbn-JKU-ch-3seg-800,800','get');
% tangkkace_cv('dbn-JKU-ch-9seg-800,800','get');
% tangkkace_cv('dbn-JKU-ch-12seg-800,800','get');
% tangkkace_cv('dbn-JKU-ns-1seg-800,800','get');
% tangkkace_cv('dbn-JKU-ns-2seg-800,800','get');
% tangkkace_cv('dbn-JKU-ns-3seg-800,800','get');
% tangkkace_cv('dbn-JKU-ns-9seg-800,800','get');
% tangkkace_cv('dbn-JKU-ns-12seg-800,800','get');
% 
% tangkkace_cv('blstm-JKU-ch-1seg-800','get');
% tangkkace_cv('blstm-JKU-ch-2seg-800','get');
% tangkkace_cv('blstm-JKU-ch-3seg-800','get');
% tangkkace_cv('blstm-JKU-ch-9seg-800','get');
% tangkkace_cv('blstm-JKU-ch-12seg-800','get');
% tangkkace_cv('blstm-JKU-ns-1seg-800','get');
% tangkkace_cv('blstm-JKU-ns-2seg-800','get');
% tangkkace_cv('blstm-JKU-ns-3seg-800','get');
% tangkkace_cv('blstm-JKU-ns-9seg-800','get');
% tangkkace_cv('blstm-JKU-ns-12seg-800','get');
% 
% % *************************** config ******************************** %
% tangkkace_cv('mlp-JKU-ch-6seg-500,500','get');
% tangkkace_cv('mlp-JKU-ch-6seg-500,500,500','get');
% tangkkace_cv('mlp-JKU-ch-6seg-500,500,500,500','get');
% tangkkace_cv('mlp-JKU-ns-6seg-500,500','get');
% tangkkace_cv('mlp-JKU-ns-6seg-500,500,500','get');
% tangkkace_cv('mlp-JKU-ns-6seg-500,500,500,500','get');
% 
% tangkkace_cv('mlp-JKU-ch-6seg-800,800','get');
% tangkkace_cv('mlp-JKU-ch-6seg-800,800,800','get');
% tangkkace_cv('mlp-JKU-ch-6seg-800,800,800,800','get');
% tangkkace_cv('mlp-JKU-ns-6seg-800,800','get');
% tangkkace_cv('mlp-JKU-ns-6seg-800,800,800','get');
% tangkkace_cv('mlp-JKU-ns-6seg-800,800,800,800','get');
% 
% tangkkace_cv('mlp-JKU-ch-6seg-1000,1000','get');
% tangkkace_cv('mlp-JKU-ch-6seg-1000,1000,1000','get');
% tangkkace_cv('mlp-JKU-ch-6seg-1000,1000,1000,1000','get');
% tangkkace_cv('mlp-JKU-ns-6seg-1000,1000','get');
% tangkkace_cv('mlp-JKU-ns-6seg-1000,1000,1000','get');
% tangkkace_cv('mlp-JKU-ns-6seg-1000,1000,1000,1000','get');
% 
% tangkkace_cv('dbn-JKU-ch-6seg-500,500','get');
% tangkkace_cv('dbn-JKU-ch-6seg-500,500,500','get');
% tangkkace_cv('dbn-JKU-ch-6seg-500,500,500,500','get');
% tangkkace_cv('dbn-JKU-ns-6seg-500,500','get');
% tangkkace_cv('dbn-JKU-ns-6seg-500,500,500','get');
% tangkkace_cv('dbn-JKU-ns-6seg-500,500,500,500','get');
% 
% tangkkace_cv('dbn-JKU-ch-6seg-800,800','get');
% tangkkace_cv('dbn-JKU-ch-6seg-800,800,800','get');
% tangkkace_cv('dbn-JKU-ch-6seg-800,800,800,800','get');
% tangkkace_cv('dbn-JKU-ns-6seg-800,800','get');
% tangkkace_cv('dbn-JKU-ns-6seg-800,800,800','get');
% tangkkace_cv('dbn-JKU-ns-6seg-800,800,800,800','get');
% 
% tangkkace_cv('dbn-JKU-ch-6seg-1000,1000','get');
% tangkkace_cv('dbn-JKU-ch-6seg-1000,1000,1000','get');
% tangkkace_cv('dbn-JKU-ch-6seg-1000,1000,1000,1000','get');
% tangkkace_cv('dbn-JKU-ns-6seg-1000,1000','get');
% tangkkace_cv('dbn-JKU-ns-6seg-1000,1000,1000','get');
% tangkkace_cv('dbn-JKU-ns-6seg-1000,1000,1000,1000','get');
% 
% % *************************** datasize ******************************** %
% tangkkace_cv('mlp-JK-ch-6seg-800,800','get');
% tangkkace_cv('mlp-JKU-ch-6seg-800,800','get');
% tangkkace_cv('mlp-JKUR-ch-6seg-800,800','get');
% tangkkace_cv('mlp-JKURB-ch-6seg-800,800','get');
% tangkkace_cv('mlp-JK-ns-6seg-800,800','get');
% tangkkace_cv('mlp-JKU-ns-6seg-800,800','get');
% tangkkace_cv('mlp-JKUR-ns-6seg-800,800','get');
% tangkkace_cv('mlp-JKURB-ns-6seg-800,800','get');
% 
% tangkkace_cv('dbn-JK-ch-6seg-800,800','get');
% tangkkace_cv('dbn-JKU-ch-6seg-800,800','get');
% tangkkace_cv('dbn-JKUR-ch-6seg-800,800','get');
% tangkkace_cv('dbn-JKURB-ch-6seg-800,800','get');
% tangkkace_cv('dbn-JK-ns-6seg-800,800','get');
% tangkkace_cv('dbn-JKU-ns-6seg-800,800','get');
% tangkkace_cv('dbn-JKUR-ns-6seg-800,800','get');
% tangkkace_cv('dbn-JKURB-ns-6seg-800,800','get');
% 
% tangkkace_cv('blstm-JK-ch-6seg-800','get');
% tangkkace_cv('blstm-JKU-ch-6seg-800','get');
% tangkkace_cv('blstm-JKUR-ch-6seg-800','get');
% tangkkace_cv('blstm-JKURB-ch-6seg-800','get');
% tangkkace_cv('blstm-JK-ns-6seg-800','get');
% tangkkace_cv('blstm-JKU-ns-6seg-800','get');
% tangkkace_cv('blstm-JKUR-ns-6seg-800','get');
% tangkkace_cv('blstm-JKURB-ns-6seg-800','get');


% massive cv testing - training error

% % *************************** segtile ******************************** %
% tangkkace_cvt('mlp-JKU-ch-1seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ch-2seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ch-3seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ch-9seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ch-12seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ns-1seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ns-2seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ns-3seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ns-9seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ns-12seg-800,800','get');
% 
% tangkkace_cvt('dbn-JKU-ch-1seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ch-2seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ch-3seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ch-9seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ch-12seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ns-1seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ns-2seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ns-3seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ns-9seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ns-12seg-800,800','get');
% 
% tangkkace_cvt('blstm-JKU-ch-1seg-800','get');
% tangkkace_cvt('blstm-JKU-ch-2seg-800','get');
% tangkkace_cvt('blstm-JKU-ch-3seg-800','get');
% tangkkace_cvt('blstm-JKU-ch-9seg-800','get');
% tangkkace_cvt('blstm-JKU-ch-12seg-800','get');
% tangkkace_cvt('blstm-JKU-ns-1seg-800','get');
% tangkkace_cvt('blstm-JKU-ns-2seg-800','get');
% tangkkace_cvt('blstm-JKU-ns-3seg-800','get');
% tangkkace_cvt('blstm-JKU-ns-9seg-800','get');
% tangkkace_cvt('blstm-JKU-ns-12seg-800','get');
% 
% % *************************** config ******************************** %
% tangkkace_cvt('mlp-JKU-ch-6seg-500,500','get');
% tangkkace_cvt('mlp-JKU-ch-6seg-500,500,500','get');
% tangkkace_cvt('mlp-JKU-ch-6seg-500,500,500,500','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-500,500','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-500,500,500','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-500,500,500,500','get');
% 
% tangkkace_cvt('mlp-JKU-ch-6seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ch-6seg-800,800,800','get');
% tangkkace_cvt('mlp-JKU-ch-6seg-800,800,800,800','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-800,800,800','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-800,800,800,800','get');
% 
% tangkkace_cvt('mlp-JKU-ch-6seg-1000,1000','get');
% tangkkace_cvt('mlp-JKU-ch-6seg-1000,1000,1000','get');
% tangkkace_cvt('mlp-JKU-ch-6seg-1000,1000,1000,1000','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-1000,1000','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-1000,1000,1000','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-1000,1000,1000,1000','get');
% 
% tangkkace_cvt('dbn-JKU-ch-6seg-500,500','get');
% tangkkace_cvt('dbn-JKU-ch-6seg-500,500,500','get');
% tangkkace_cvt('dbn-JKU-ch-6seg-500,500,500,500','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-500,500','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-500,500,500','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-500,500,500,500','get');
% 
% tangkkace_cvt('dbn-JKU-ch-6seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ch-6seg-800,800,800','get');
% tangkkace_cvt('dbn-JKU-ch-6seg-800,800,800,800','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-800,800,800','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-800,800,800,800','get');
% 
% tangkkace_cvt('dbn-JKU-ch-6seg-1000,1000','get');
% tangkkace_cvt('dbn-JKU-ch-6seg-1000,1000,1000','get');
% tangkkace_cvt('dbn-JKU-ch-6seg-1000,1000,1000,1000','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-1000,1000','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-1000,1000,1000','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-1000,1000,1000,1000','get');
% 
% % *************************** datasize ******************************** %
% tangkkace_cvt('mlp-JK-ch-6seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ch-6seg-800,800','get');
% tangkkace_cvt('mlp-JKUR-ch-6seg-800,800','get');
% tangkkace_cvt('mlp-JKURB-ch-6seg-800,800','get');
% tangkkace_cvt('mlp-JK-ns-6seg-800,800','get');
% tangkkace_cvt('mlp-JKU-ns-6seg-800,800','get');
% tangkkace_cvt('mlp-JKUR-ns-6seg-800,800','get');
% tangkkace_cvt('mlp-JKURB-ns-6seg-800,800','get');
% 
% tangkkace_cvt('dbn-JK-ch-6seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ch-6seg-800,800','get');
% tangkkace_cvt('dbn-JKUR-ch-6seg-800,800','get');
% tangkkace_cvt('dbn-JKURB-ch-6seg-800,800','get');
% tangkkace_cvt('dbn-JK-ns-6seg-800,800','get');
% tangkkace_cvt('dbn-JKU-ns-6seg-800,800','get');
% tangkkace_cvt('dbn-JKUR-ns-6seg-800,800','get');
% tangkkace_cvt('dbn-JKURB-ns-6seg-800,800','get');
% 
% tangkkace_cvt('blstm-JK-ch-6seg-800','get');
% tangkkace_cvt('blstm-JKU-ch-6seg-800','get');
% tangkkace_cvt('blstm-JKUR-ch-6seg-800','get');
% tangkkace_cvt('blstm-JKURB-ch-6seg-800','get');
% tangkkace_cvt('blstm-JK-ns-6seg-800','get');
% tangkkace_cvt('blstm-JKU-ns-6seg-800','get');
% tangkkace_cvt('blstm-JKUR-ns-6seg-800','get');
% tangkkace_cvt('blstm-JKURB-ns-6seg-800','get');

% % *************************** songwise ******************************** %
% tangkkace_cv('X-CJKURB-ch-songwise-X','put');
% tangkkace_cv('X-CJKURB-ns-songwise-X','put');

% % *************************** testing error ******************************** %
% tangkkace_cv('blstmrnn-JK-ch-songwise-800','get');
% tangkkace_cv('blstmrnn-JKU-ch-songwise-800','get');
% tangkkace_cv('blstmrnn-JKUR-ch-songwise-800','get');
% tangkkace_cv('blstmrnn-JKURB-ch-songwise-800','get');
% tangkkace_cv('blstmrnn-JK-ns-songwise-800','get');
% tangkkace_cv('blstmrnn-JKU-ns-songwise-800','get');
% tangkkace_cv('blstmrnn-JKUR-ns-songwise-800','get');
% tangkkace_cv('blstmrnn-JKURB-ns-songwise-800','get');
% 
% tangkkace_cv('blstmrnn_ec-JK-ch-songwise-800','get');
% tangkkace_cv('blstmrnn_ec-JKU-ch-songwise-800','get');
% tangkkace_cv('blstmrnn_ec-JKUR-ch-songwise-800','get');
% tangkkace_cv('blstmrnn_ec-JKURB-ch-songwise-800','get');
% tangkkace_cv('blstmrnn_ec-JK-ns-songwise-800','get');
% tangkkace_cv('blstmrnn_ec-JKU-ns-songwise-800','get');
% tangkkace_cv('blstmrnn_ec-JKUR-ns-songwise-800','get');
% tangkkace_cv('blstmrnn_ec-JKURB-ns-songwise-800','get');

% % *************************** training error ******************************** %
% tangkkace_cvt('blstmrnn-JK-ch-songwise-800','get');
% tangkkace_cvt('blstmrnn-JKU-ch-songwise-800','get');
% tangkkace_cvt('blstmrnn-JKUR-ch-songwise-800','get');
% tangkkace_cvt('blstmrnn-JKURB-ch-songwise-800','get');
% tangkkace_cvt('blstmrnn-JK-ns-songwise-800','get');
% tangkkace_cvt('blstmrnn-JKU-ns-songwise-800','get');
% tangkkace_cvt('blstmrnn-JKUR-ns-songwise-800','get');
% tangkkace_cvt('blstmrnn-JKURB-ns-songwise-800','get');
% 
% tangkkace_cvt('blstmrnn_ec-JK-ch-songwise-800','get');
% tangkkace_cvt('blstmrnn_ec-JKU-ch-songwise-800','get');
% tangkkace_cvt('blstmrnn_ec-JKUR-ch-songwise-800','get');
% tangkkace_cvt('blstmrnn_ec-JKURB-ch-songwise-800','get');
% tangkkace_cvt('blstmrnn_ec-JK-ns-songwise-800','get');
% tangkkace_cvt('blstmrnn_ec-JKU-ns-songwise-800','get');
% tangkkace_cvt('blstmrnn_ec-JKUR-ns-songwise-800','get');
% tangkkace_cvt('blstmrnn_ec-JKURB-ns-songwise-800','get');
