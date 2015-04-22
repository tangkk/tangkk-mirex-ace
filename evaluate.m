% The following evaluator is built and executed from Johan's source code:
% https://github.com/jpauwels/MusOOEvaluator

sufix = '-full';
evallist = 'evallist.txt';

gtroot = './gt/';
cproot = './cp/';
cdroot = './cd/'; % cd = chordino
gtfolder = strcat(gtroot,'/');
cpfolder = strcat(cproot,'/');
cdfolder = strcat(cdroot,'/');

testfolder = cpfolder;

outroot = './out/';

% ************************ Chords *************************** %
evaltype = 'Root';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'Bass';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexRoot';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexMajMin';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexMajMinBass';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexSevenths';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexSeventhsBass';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'ChromaRecall';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'ChromaPrecision';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'ChromaFmeasure';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'Mirex2010';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

% **************** segmentation ****************

evaltype = 'Onset';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix 'Seg.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

evaltype = 'Offset';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix 'Seg.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

evaltype = 'Inner';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix 'Seg.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

evaltype = 'Outer';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix 'Seg.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    testfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

