% this function combine a set of CV folds to bigger folds
% the setList could be as long as 'CJKURB'

function cvCombine(setList,foldnum,nseg)

disp(['now doing ' setList '-' num2str(foldnum) '-' num2str(nseg)]);

savns = ['data/cv/' setList '-' num2str(foldnum) '-ns-' num2str(nseg) 'seg' '.mat'];
savch = ['data/cv/' setList '-' num2str(foldnum) '-ch-' num2str(nseg) 'seg' '.mat'];

Xns = [];
yns = [];

Xch = [];
ych = [];

if sum(setList == 'C') > 0 % C case
    C = load(['data/cvraw/CNPop20List-' num2str(foldnum) '-' num2str(nseg) 'seg' '.mat']);
    Xns = [Xns;C.trainingDataX11];
    yns = [yns;C.trainingDatay11];
    Xch = [Xch;C.trainingDataX22];
    ych = [ych;C.trainingDatay22];
end
if sum(setList == 'J') > 0 % C case
    J = load(['data/cvraw/JayChou29List-' num2str(foldnum) '-' num2str(nseg) 'seg' '.mat']);
    Xns = [Xns;J.trainingDataX11];
    yns = [yns;J.trainingDatay11];
    Xch = [Xch;J.trainingDataX22];
    ych = [ych;J.trainingDatay22];
end
if sum(setList == 'K') > 0 % C case
    K = load(['data/cvraw/CaroleKingQueen26List-' num2str(foldnum) '-' num2str(nseg) 'seg' '.mat']);
    Xns = [Xns;K.trainingDataX11];
    yns = [yns;K.trainingDatay11];
    Xch = [Xch;K.trainingDataX22];
    ych = [ych;K.trainingDatay22];
end
if sum(setList == 'U') > 0 % C case
    U = load(['data/cvraw/USPop191List-' num2str(foldnum) '-' num2str(nseg) 'seg' '.mat']);
    Xns = [Xns;U.trainingDataX11];
    yns = [yns;U.trainingDatay11];
    Xch = [Xch;U.trainingDataX22];
    ych = [ych;U.trainingDatay22];
end
if sum(setList == 'R') > 0 % C case
    R = load(['data/cvraw/RWC100List-' num2str(foldnum) '-' num2str(nseg) 'seg' '.mat']);
    Xns = [Xns;R.trainingDataX11];
    yns = [yns;R.trainingDatay11];
    Xch = [Xch;R.trainingDataX22];
    ych = [ych;R.trainingDatay22];
end
if sum(setList == 'B') > 0 % C case
    B = load(['data/cvraw/TheBeatles180List-' num2str(foldnum) '-' num2str(nseg) 'seg' '.mat']);
    Xns = [Xns;B.trainingDataX11];
    yns = [yns;B.trainingDatay11];
    Xch = [Xch;B.trainingDataX22];
    ych = [ych;B.trainingDatay22];
end

X = Xns;
y = yns;
save(savns,'X','y');

X = Xch;
y = ych;
save(savch,'X','y');

