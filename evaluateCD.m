% The following evaluator is built and executed from Johan's source code:
% https://github.com/jpauwels/MusOOEvaluator

sufix = 'chordino';
evallist = 'evallist.txt';

gtroot = './gt/';
cdroot = './cd/';
gtfolder = strcat(gtroot);
cdfolder = strcat(cdroot);

testfolder = cdfolder;

outroot = './outcd/';

% **************** segmentation ****************
evaltype = 'Inner';
disp([evaltype '......']);
evalout = [outroot 'results' 'Segmentation' '/' sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

% ************************ Chords *************************** %
evaltype = 'Bass';
disp([evaltype '......']);
evalout = [outroot 'results' evaltype '/' sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexRoot';
disp([evaltype '......']);
evalout = [outroot 'results' evaltype '/' sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexMajMin';
disp([evaltype '......']);
evalout = [outroot 'results' evaltype '/' sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexMajMinBass';
disp([evaltype '......']);
evalout = [outroot 'results' evaltype '/' sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexSevenths';
disp([evaltype '......']);
evalout = [outroot 'results' evaltype '/' sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexSeventhsBass';
disp([evaltype '......']);
evalout = [outroot 'results' evaltype '/' sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

% evaltype = 'ChromaRecall';
% disp([evaltype '......']);
% evalout = [outroot 'results' evaltype '/' sufix '.txt'];
% evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
%     testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
%     ' --chords ' evaltype];
% system(evalcmd);
% 
% evaltype = 'ChromaPrecision';
% disp([evaltype '......']);
% evalout = [outroot 'results' evaltype '/' sufix '.txt'];
% evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
%     testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
%     ' --chords ' evaltype];
% system(evalcmd);
% 
% evaltype = 'ChromaFmeasure';
% disp([evaltype '......']);
% evalout = [outroot 'results' evaltype '/' sufix '.txt'];
% evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
%     testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
%     ' --chords ' evaltype];
% system(evalcmd);
