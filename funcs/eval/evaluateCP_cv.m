% The following evaluator is built and executed from Johan's source code:
% https://github.com/jpauwels/MusOOEvaluator

% original function evaluateCP(suffix, evallistin)
function evaluateCP_cv(suffix, evallistins)

fw = fopen(['e' evallistins],'w+');

strtoks = strsplit(evallistins,'-');
dataset = strtoks(1);
fold = strtoks(2);

% dump the content of each datasets into fw
for dsi = 1:length(dataset)
    ts = dataset(dsi);
    if strcmp(ts,'C')
        thisset = 'CNPop20List';
    elseif strcmp(ts,'J')
        thisset = 'JayChou29List';
    elseif strcmp(ts,'K')
        thisset = 'CaroleKingQueen26List';
    elseif strcmp(ts,'U')
        thisset = 'USPop191List';
    elseif strcmp(ts,'R')
        thisset = 'RWC100List';
    elseif strcmp(ts,'B')
        thisset = 'TheBeatles180List';
    else
        thisset = '';
    end
    
    evallistin = ['data/cvlist/', thisset, '-', fold];
    
    
    fr = fopen(evallistin,'r');

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
end

fclose(fw);

evallist = ['e' evallistins];

gtroot = './gt/';
cproot = './cp/';
gtfolder = strcat(gtroot);
cpfolder = strcat(cproot);

testfolder = cpfolder;

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

% ************************ Chords *************************** %
evaltype = 'Bass';
disp([evaltype '......']);
evaloutbass = [outroot 'results' evaltype '/' suffix '.txt'];
confbass = [outroot 'results' evaltype '/' suffix '.con.csv'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evaloutbass ' --csv'...
    ' --chords ' evaltype ' --confusion ' confbass];
system(evalcmd);
dbtype(evaloutbass,'3:7');

evaltype = 'MirexRoot';
disp([evaltype '......']);
evaloutroot = [outroot 'results' evaltype '/' suffix '.txt'];
confroot = [outroot 'results' evaltype '/' suffix '.con.csv'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evaloutroot ' --csv'...
    ' --chords ' evaltype ' --confusion ' confroot];
system(evalcmd);
dbtype(evaloutroot,'3:7');

evaltype = 'MirexMajMin';
disp([evaltype '......']);
evaloutmajmin = [outroot 'results' evaltype '/' suffix '.txt'];
confmajmin = [outroot 'results' evaltype '/' suffix '.con.csv'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evaloutmajmin ' --csv'...
    ' --chords ' evaltype ' --confusion ' confmajmin];
system(evalcmd);
dbtype(evaloutmajmin,'3:7');

evaltype = 'MirexMajMinBass';
disp([evaltype '......']);
evaloutmajminbass = [outroot 'results' evaltype '/' suffix '.txt'];
confmajminbass = [outroot 'results' evaltype '/' suffix '.con.csv'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evaloutmajminbass ' --csv'...
    ' --chords ' evaltype ' --confusion ' confmajminbass];
system(evalcmd);
dbtype(evaloutmajminbass,'3:7');

evaltype = 'MirexSevenths';
disp([evaltype '......']);
evaloutsevenths = [outroot 'results' evaltype '/' suffix '.txt'];
confsevenths = [outroot 'results' evaltype '/' suffix '.con.csv'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evaloutsevenths ' --csv'...
    ' --chords ' evaltype ' --confusion ' confsevenths];
system(evalcmd);
dbtype(evaloutsevenths,'3:7');

evaltype = 'MirexSeventhsBass';
disp([evaltype '......']);
evaloutseventhsbass = [outroot 'results' evaltype '/' suffix '.txt'];
confseventhsbass = [outroot 'results' evaltype '/' suffix '.con.csv'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evaloutseventhsbass ' --csv'...
    ' --chords ' evaltype ' --confusion ' confseventhsbass];
system(evalcmd);
dbtype(evaloutseventhsbass,'3:7');

% evaltype = 'ChromaRecall';
% disp([evaltype '......']);
% evalout = [outroot 'results' evaltype '/' suffix '.txt'];
% evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
%     testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
%     ' --chords ' evaltype];
% system(evalcmd);
% 
% evaltype = 'ChromaPrecision';
% disp([evaltype '......']);
% evalout = [outroot 'results' evaltype '/' suffix '.txt'];
% evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
%     testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
%     ' --chords ' evaltype];
% system(evalcmd);
% 
% evaltype = 'ChromaFmeasure';
% disp([evaltype '......']);
% evalout = [outroot 'results' evaltype '/' suffix '.txt'];
% evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
%     testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
%     ' --chords ' evaltype];
% system(evalcmd);

