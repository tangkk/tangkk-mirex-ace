% this function combine a set folds to bigger folds
% the setList could be as long as 'CJKURB'

function foldCombine(setList,nseg)

Xns = [];
yns = [];

Xch = [];
ych = [];

savns = [setList '-ns-' num2str(nseg) 'seg' '.mat'];
savch = [setList '-ch-' num2str(nseg) 'seg' '.mat'];

if sum(setList == 'C') > 0 % C case
    for i = 1:5
        C = load(['data/cvraw/CNPop20List-' num2str(i) '-' num2str(nseg) 'seg' '.mat']);
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