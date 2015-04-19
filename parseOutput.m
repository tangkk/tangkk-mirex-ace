% parse the output or ground-truth file according to the MIREX 2015 ACE
% http://www.music-ir.org/mirex/wiki/2015:Audio_Chord_Estimation
% There are totally 8 different measures:
% 1, root; 2,majmin; 3,majminbass; 4, seventh; 5, seventhbass 6,bass;
% 7, chroma recall/precision; 8,tetrad
% for example, here a email replied from Johan Pauwels:

% Mirex          Roots	MirexMajMin	MirexMajMinBass	MirexSevenths	MirexSeventhsBass	Bass	ChromaRecall/Precision	Tetrads
% Ref G/F	     G	    G:maj	    G:maj	        G:7	            G:7/b7	            F	    {B D F G}	            G:7
% Test F	     F	    F:maj	    F:maj	        F:maj	        F:maj	            F	    {A C F}	                F:maj
% Ref C:maj6	 C	    C:maj	    C:maj	        X (C:maj6)	    X (C:maj6)	        C	    {A C E G}	            C:maj6
% Test A:min7/b  A	    A:min	    A:min/b3	    A:min7	        A:min7/b3	        C	    {A C E G}	            A:min7

% there are 3 pieces of information needed for no matter which evaluation,
% 1, root; 2, quality (such as maj, min, etc.); 3, bass

% this file returns the progression of these three elements of the given text

function [rootgram, bassgram, qualgram, boundaries] = parseOutput(path)

bassgram = [];
rootgram = [];
qualgram = {};
boundaries = [];

fr = fopen(path,'r');
tline = fgets(fr);
while ischar(tline) && length(tline) > 1
    tokens = strsplit(tline);
    st = tokens{1};
    et = tokens{2};
    ch = tokens{3};
    
    % parse every chord into root, quality and bass
    [root, qual, bass] = parseChord(ch);
    
    % build the relative grams
    rootgram = [rootgram root];
    qualgram = [qualgram qual];
    bassgram = [bassgram bass];
    
    % parse seconds
    sec = str2double(st);
    boundaries = [boundaries sec];
    tline = fgets(fr);
end

% parse the end time
esec = str2double(et);
boundaries = [boundaries esec];

fclose(fr);
