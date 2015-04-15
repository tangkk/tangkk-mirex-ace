% generate lrc file from reaper marker output
target = 'anjing';
lrcpath = strcat('../AudioSamples/',target,'/');

% transform reaper markers to lrc
fr = fopen(strcat(lrcpath,'markers.txt'),'r');
fw = fopen(strcat(lrcpath,target,'.gt.lrc'),'w');
tline = fgets(fr);
skip = 0;
while ischar(tline) && length(tline) > 1
    if skip
        skip = 0;
        tline = fgets(fr);
        continue;
    end
    tline(2:3) = '';
    fprintf(fw,'%s',tline);
    tline = fgets(fr);
    skip = 1;
end
fclose(fr);
fclose(fw);

% transform chordino output to lrc
fr = fopen(strcat(lrcpath,'chordino.txt'),'r');
fw = fopen(strcat(lrcpath,target,'.cd.lrc'),'w');
tline = fgets(fr);
while ischar(tline) && length(tline) > 1
    [t,chord] = strtok(tline,char(9)); %char(9) is a tab
    sec = str2double(t);
    timestr = strcat(num2str(floor(sec/60)),':',num2str(mod(sec,60)));
    chord = chord(2:end);
    s = strcat('[',timestr,']',chord);
    fprintf(fw,'%s\n',s);
    tline = fgets(fr);
end
fclose(fr);
fclose(fw);