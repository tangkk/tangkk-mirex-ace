% this function combine a set folds to bigger folds
% the setList could be as long as 'CJKURB'

function foldCombine_songwise(setList)

Xns = {};
yns = {};

Xch = {};
ych = {};

savns = ['data/cvsong/' setList '-ns-' 'songwise' '.mat'];
savch = ['data/cvsong/' setList '-ch-' 'songwise' '.mat'];

if sum(setList == 'C') > 0 % C case
    for i = 1:5
        C = load(['data/cvraw-songwise/CNPop20List-' num2str(i) '-' 'songwise' '.mat']);
        Xns = [Xns,C.trainingDataX11];
        yns = [yns,C.trainingDatay11];
        Xch = [Xch,C.trainingDataX22];
        ych = [ych,C.trainingDatay22];
    end
end

X = Xns;
y = yns;
save(savns,'X','y','-v7.3');

X = Xch;
y = ych;
save(savch,'X','y','-v7.3');