% The following evaluator is built and executed from Johan's source code:
% https://github.com/jpauwels/MusOOEvaluator
%
% ACE Evaluation presets
% 
% Triads
% Tetrads
% TriadsInput
% TetradsOnly
% Bass
% Root
% ChromaRecall
% ChromaPrecision
% ChromaFmeasure
% Mirex2009
% Mirex2010
% 4TriadsInput
% 4TriadsOutput
% 6TriadsInput
% 6TriadsOutput
% MirexMajMin
% MirexMajMinBass
% MirexSevenths
% MirexSeventhsBass
% MirexRoot

% for example:
% Mirex          Roots	MirexMajMin	MirexMajMinBass	MirexSevenths	MirexSeventhsBass	Bass	ChromaRecall/Precision	Tetrads
% Ref G/F	     G	    G:maj	    G:maj	        G:7	            G:7/b7	            F	    {B D F G}	            G:7
% Test F	     F	    F:maj	    F:maj	        F:maj	        F:maj	            F	    {A C F}	                F:maj
% Ref C:maj6	 C	    C:maj	    C:maj	        X (C:maj6)	    X (C:maj6)	        C	    {A C E G}	            C:maj6
% Test A:min7/b  A	    A:min	    A:min/b3	    A:min7	        A:min7/b3	        C	    {A C E G}	            A:min7

% segmentation evaluation
% Segmentation
% 
% Onset
% Offset
% Inner
% Outer


artist = 'demoartist';
album = 'demoalbum';
sufix = '-semict-con0.2';
evallist = 'evallist.txt';

gtroot = './gt/';
cproot = './cp/';
gtfolder = strcat(gtroot,artist,'/',album,'/');
cpfolder = strcat(cproot,artist,'/',album,'/');

outroot = './out/';

% ************************ Chords *************************** %
evaltype = 'Root';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'Bass';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexRoot';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexMajMin';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'MirexMajMinBass';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

% evaltype = 'MirexSevenths';
% disp([evaltype '......']);
% evalout = [outroot album evaltype sufix '.txt'];
% evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
%     cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
%     ' --chords ' evaltype];
% system(evalcmd);
% 
% evaltype = 'MirexSeventhsBass';
% disp([evaltype '......']);
% evalout = [outroot album evaltype sufix '.txt'];
% evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
%     cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
%     ' --chords ' evaltype];
% system(evalcmd);

evaltype = 'ChromaRecall';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'ChromaPrecision';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'ChromaFmeasure';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

evaltype = 'Mirex2010';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix '.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --chords ' evaltype];
system(evalcmd);

% **************** segmentation ****************

evaltype = 'Onset';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix 'Seg.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

evaltype = 'Offset';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix 'Seg.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

evaltype = 'Inner';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix 'Seg.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

evaltype = 'Outer';
disp([evaltype '......']);
evalout = [outroot album evaltype sufix 'Seg.txt'];
evalcmd = ['eval --list ' evallist ' --refdir ' gtfolder ' --testdir '...
    cpfolder ' --refext .lab --testext .txt --output ' evalout ' --csv'...
    ' --segmentation ' evaltype];
system(evalcmd);

