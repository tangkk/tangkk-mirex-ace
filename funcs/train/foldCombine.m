% this function combine a set folds to bigger folds
% the setList could be as long as 'CJKURB'

function foldCombine(savns,savch,setList)

Xns = [];
yns = [];

Xch = [];
ych = [];

if sum(setList == 'C') > 0 % C case
    for i = 1:5
        C = load(['cv/CNPop20List-' num2str(i) '.mat']);
        Xns = [Xns;C.trainingDataX11];
        yns = [yns;C.trainingDatay11];
        Xch = [Xch;C.trainingDataX22];
        ych = [ych;C.trainingDatay22];
    end
end

X = Xns;
y = yns;
save(savns,'X','y');

X = Xch;
y = ych;
save(savch,'X','y');