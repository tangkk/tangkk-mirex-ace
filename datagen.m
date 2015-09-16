% Generate training set, validation set and test set given the data we have
function datagen(data1,data2)
dataJ = load(data1);
dataB = load(data2);

mJ = size(dataJ.y,1);
mB = size(dataB.y,1);
pB = floor(mB/3); % fix partition

% use JayChou Set alone as training set
data.training.inputs = [dataJ.X]';
data.training.targets = [dataJ.y]';

% % using Beatles Set only
% data.training.inputs = dataB.X(1:pB,:)';
% data.training.targets = dataB.y(1:pB,:)';

% % using JayChou set and 1/3 of Beatles set as training set (Both supervised and unsupervised)
% data.training.inputs = [dataJ.X; dataB.X(1:pB,:)]';
% data.training.targets = [dataJ.y; dataB.y(1:pB,:)]';

% using part of Beatles as validation set
data.validation.inputs = dataB.X(pB+1:2*pB,:)';
data.validation.targets = dataB.y(pB+1:2*pB,:)';

% using the other part of Beatles as test set
data.test.inputs = dataB.X(2*pB+1:end,:)';
data.test.targets = dataB.y(2*pB+1:end,:)';

save data.mat data