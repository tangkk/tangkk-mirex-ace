function wcsr = evaluateJazzAll(suffix, evallistin)

fr = fopen(evallistin,'r');
fw = fopen(['e' evallistin],'w+');
tline = fgetl(fr);
if ispc
    formatSpec = '%s\r\n';
else
    formatSpec = '%s\n';
end
while ischar(tline)
    sufposes = strfind(tline,'.');
    ntline = tline(1:sufposes(end)-1);
    fprintf(fw, formatSpec, ntline);
    tline = fgetl(fr);
end
fclose(fr);
fclose(fw);

evallist = ['e' evallistin];

gtroot = './gt/';
cproot = './cp/';
gtfolder = strcat(gtroot);
cpfolder = strcat(cproot);
testfolder = cpfolder;

load chordnames-jazz-all.mat;
load chordmode-jazz-all.mat;


% evaluate segmentation
outroot = './out/';
% **************** segmentation ****************
evaltype = 'Inner';
disp([evaltype '......']);
evaloutseg = [outroot 'results' 'Segmentation' '/' suffix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evaloutseg ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);
dbtype(evaloutseg,'3:7');



wcsr = [];
TDs = [];

display('now computing wcsr...');
fe = fopen(evallist,'r');
tline = fgetl(fr);
while ischar(tline)
    % get the paths of both gt and cp transcriptions of one piece
    gtpath = [gtroot tline '.lab'];
    cppath = [cproot tline '.txt'];
    
    % iterate over the transcriptions of this piece to record:
    % 1: rootgram, 2: treblegram, 3: segmentations
    
    % first iterate over gt
    gtsegments = [];
    gtrootgram = [];
    gttreblegram = [];
    fgt = fopen(gtpath,'r');
    gtline = fgetl(fgt);
    while ischar(gtline)
       strtoks = strsplit(gtline,' ');
       st = strtoks{1};
       et = strtoks{2};
       ch = strtoks{3};
       
       gtsegments = [gtsegments str2double(st)];
       gtchnum = chname2chnum(ch, chordmode);
       strtoks = strsplit(gtchnum,':');
       gtrootgram = [gtrootgram str2double(strtoks(1))];
       gttreblegram = [gttreblegram str2double(strtoks(1))];
       gtline = fgetl(fgt);
    end
    gtsegments = [gtsegments str2double(et)];
    TD = str2double(et);
    fclose(fgt);
    
    % then do the same for cp
    cpsegments = [];
    cprootgram = [];
    cptreblegram = [];
    fcp = fopen(cppath,'r');
    cpline = fgetl(fcp);
    while ischar(cpline)
       strtoks = strsplit(cpline,' ');
       st = strtoks{1};
       et = strtoks{2};
       ch = strtoks{3};

       cpsegments = [cpsegments str2double(st)];
       cpchnum = chname2chnum(ch, chordmode);
       strtoks = strsplit(cpchnum,':');
       cprootgram = [cprootgram str2double(strtoks(1))];
       cptreblegram = [cptreblegram str2double(strtoks(1))];
       cpline = fgetl(fcp);
    end
    cpsegments = [cpsegments str2double(et)];
    fclose(fcp);
    
    % then do a comparison
    csr = computeCSR(gtrootgram, gttreblegram, gtsegments, cprootgram, cptreblegram, cpsegments, TD);
    
    wcsr = [wcsr csr];
    TDs = [TDs TD];
    
    tline = fgetl(fr);
end
fclose(fe);

% compute wcsr
wcsr = wcsr*TDs' / sum(TDs);
disp('wcsr = ');
disp(wcsr);

respath = ['out/' suffix '.txt'];
fejazz = fopen(respath,'w');
fprintf(fejazz,'%s',wcsr);
fclose(fejazz);



