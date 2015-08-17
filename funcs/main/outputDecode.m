function outFile = outputDecode(inFile, outFileDir)

pathtokens = strsplit(inFile,'/');
inFileName = pathtokens{end};
outFile = strcat(outFileDir, inFileName, '.txt');

