% show the outputs

function stable = showresults(resultpath)

tmp = dir([resultpath '/' 'results' 'Bass']);
tmptxt = tmp(4).name;
suffix = tmptxt(1:end-4);

evaloutseg = [resultpath '/' 'results' 'Segmentation' '/' suffix '.txt'];
evaloutbass = [resultpath '/' 'results' 'Bass' '/' suffix '.txt'];
evaloutroot = [resultpath '/' 'results' 'MirexRoot' '/' suffix '.txt'];
evaloutmajmin = [resultpath '/' 'results' 'MirexMajMin' '/' suffix '.txt'];
evaloutmajminbass = [resultpath '/' 'results' 'MirexMajMinBass' '/' suffix '.txt'];
evaloutsevenths = [resultpath '/' 'results' 'MirexSevenths' '/' suffix '.txt'];
evaloutseventhsbass = [resultpath '/' 'results' 'MirexSeventhsBass' '/' suffix '.txt'];

dbtype(evaloutbass,'3:7');
dbtype(evaloutmajmin,'3:7');
dbtype(evaloutmajminbass,'3:7');
dbtype(evaloutmajminbass,'17:26');
dbtype(evaloutroot,'3:7');
dbtype(evaloutsevenths,'3:7');
dbtype(evaloutsevenths,'17:23');
dbtype(evaloutseventhsbass,'3:7');
dbtype(evaloutseventhsbass,'17:41');
dbtype(evaloutseg,'3:7');
disp(suffix);

% save the seventhsbass output to a table for recording
fr = fopen(evaloutseventhsbass,'r');
tline = fgetl(fr);
li = 1;
stable = cell(2,23);
while ischar(tline)
    if li >= 19 && li <= 41
        strtoks1 = strsplit(tline,':');
        ch = strtoks1{1};
        strtoks2 = strsplit(strtoks1{2},{'(',')'});
        per = strtoks2{2};
        dper = str2double(per(1:end-1)); % delete the '%' symbol
        tol = strtoks2{4};
        stable{1, li - 18} = ch;
        stable{2, li - 18} = dper;
        stable{3, li - 18} = tol;
    end
    tline = fgetl(fr);
    li = li+1;
end
fclose(fr);

