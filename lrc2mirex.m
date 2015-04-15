% convert lrc file to standard MIREX format (with '.txt' suffix)
target = 'demo';
lrcpath = strcat('./gt/',target,'.gt.lrc');
mirexpath = strcat('./gt/',target,'.gt.txt');

fr = fopen(lrcpath,'r');
fw = fopen(mirexpath,'w');

tline = fgets(fr);
while ischar(tline) && length(tline) > 1
    thisline = tline;
    tline = fgets(fr);
    if length(tline) <= 1
        break;
    end
    nextline = tline;
    tsplit = strsplit(thisline,']');
    nsplit = strsplit(nextline,']');
    ttime = tsplit{1}; tlab = tsplit{2};
    ntime = nsplit{1}; nlab = nsplit{2};
    ttime = ttime(2:end); ntime = ntime(2:end);
    tsecs = strsplit(ttime,':'); nsecs = strsplit(ntime,':');
    tsec = str2double(tsecs{1})*60 + str2double(tsecs{2});
    nsec = str2double(nsecs{1})*60 + str2double(nsecs{2});
    strout = [num2str(tsec) ' ' num2str(nsec) ' ' tlab];
    fprintf(fw,'%s',strout);
end
fclose(fr);
fclose(fw);