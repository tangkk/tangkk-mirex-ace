% work with TheanoNN
function [rootgram, bassgram, treblegram] = nnn6Decode(chordmode, ns, bdrys, model, nseg)

rootgram = [];
bassgram = [];
treblegram = [];

nslices = size(bdrys,2)-1;
% nseg = 6;

% step 1, generate the 6seg samples from rawbasegram and rawuppergram - store X
X = zeros(1,252*nseg);
for j = 1:nslices
    sb = bdrys(j);
    eb = bdrys(j+1);
    sm = ns(:,sb:eb);
    smnseg = zeros(252,nseg);

    % seperate each segment into nseg sections (along time axis) and take average upon the
    % segments
    lenseg = eb-sb+1; % length of the whole segment
    lensec = max(floor(lenseg / nseg),1); % length of each section
    for i = 1:nseg
        smsec = mean(sm(:,min((i-1)*lensec+1,lenseg): min(i*lensec,lenseg)),2);
        smnseg(:,i) = smsec;
    end
    tcase = smnseg(:);
    X(j,:) = tcase';
end

save('./data/temp/X.mat','X');

% extract info from model
if ~isempty(strfind(model,'-inv-')) || ~isempty(strfind(model,'Inv'))
    invtype = 'inv';
    load('chordnames-inv.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-noinv-')) || ~isempty(strfind(model,'Noinv'))
    invtype = 'noinv';
    load('chordnames-noinv.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-no7-')) || ~isempty(strfind(model,'No7'))
    invtype = 'no7';
    load('chordnames-no7.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-jazz-'))
    invtype = 'jazz';
    load('chordnames-jazz.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-jazzall-'))
    invtype = 'jazzall';
    load('chordnames-jazz-all.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-full-'))
    invtype = 'full';
    load('chordnames-full.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
elseif ~isempty(strfind(model,'-Mm-'))
    invtype = 'Mm';
    load('chordnames-Mm.mat');
    chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
end

if ~isempty(strfind(model,'mlp'))
    nntype = 'mlp';
elseif ~isempty(strfind(model,'dbn'))
    nntype = 'dbn';
elseif ~isempty(strfind(model,'blstm'))
    nntype = 'blstm';
elseif ~isempty(strfind(model,'lstm'))
    nntype = 'lstm';
elseif ~isempty(strfind(model,'knn'))
    nntype = 'knn';
elseif ~isempty(strfind(model,'svm'))
    nntype = 'svm';
end
% execute python prediction script to predict X
% pythoncmd = {'nn/predict.py','./data/temp/X.mat',['./data/model/' model],nntype,invtype};
% python(pythoncmd)

% ************ use the trained model to predict chordbeats/whatever ************ %
% pythoncmd = {'nn/predict.py','./temp/X.mat',['./model/' model]};
% python(pythoncmd)
% the content of python.m may subject to change when you use a different environment
% especially the Execute Python script part

% my local machine cannot do this well
% relay this task to remote machine
remotehost = '10.16.0.53';
remotepath = '~/Documents/Projects/ace/data/temp/';
localpath = './data/temp/';
remoteace = '~/Documents/Projects/ace/';
scp_simple_put(remotehost,'test','test','X.mat',remotepath,localpath,'X.mat');
% let the remote run to predict on this thing
% command = ['python ', remoteace,'nnn/predict.py ',remoteace, 'temp/X.mat ', remoteace, 'model/',model,' ', remoteace, 'temp/'];
command = ['python ', remoteace,'nnn/predict.py ',remoteace, 'temp/X.mat ', remoteace, 'model/',model,' ', nntype, ' ', invtype];
command_result = ssh2_simple_command(remotehost,'test','test', command, 1);
% get the remote preds back
scp_simple_get(remotehost,'test','test', 'y_preds.mat', localpath, remotepath);
scp_simple_get(remotehost,'test','test', 'y_probs.mat', localpath, remotepath);


% the output of the process is saved to ./data/temp/y_probs.mat and
% ./data/temp/y_preds.mat
load('./data/temp/y_preds.mat');
y_preds = y_preds';

for j = 1:nslices
    out = y_preds(j);
    chnum = chordnums{out};
    strtoks = strsplit(chnum,':');
    root = str2double(strtoks{1});
    treble = str2double(strtoks{2});
    if root ~= 0 && treble ~= 0
        rootgram(j) = root;
        treblegram(j) = treble;
        bassgram(j) = root2bass(root,chordmode{2,treble});
    else
        rootgram(j) = 0;
        treblegram(j) = 0;
        bassgram(j) = 0;
    end
end

display('chord progression done...');
