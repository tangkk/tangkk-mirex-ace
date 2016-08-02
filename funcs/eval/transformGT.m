% transform sonic-visualizer annotation output .txt to .lab that can be recognized by
% evaluation tools


target = './gt/JazzBook/PracJazz/';
load chordmode-jazz.mat;
typecount = zeros(1,size(chordmode,2)+1);

filelist = dir(target);

ninv = 0; % count the total chord inversions
nch = 0; % count total chords
for i = 3:size(filelist,1)
    
filestruct = filelist(i);
filename =filestruct.name;

filepath = [target filename(1:end-4)];

in = [filepath '.txt'];
out = [filepath '.lab'];
fr = fopen(in,'r');
fw = fopen(out,'w');

tline = fgetl(fr);
while ischar(tline)
    tokens = strsplit(tline,'\t');
    st1 = tokens{1};
    ch1 = tokens{2};
    
    disp(ch1);
    
    nch = nch + 1;
    if ~isempty(strfind(ch1,'/'))
        ninv = ninv + 1;
    end
    
    % count the number of chord types
    if strcmp(ch1,'N')
        typecount(end) = typecount(end)+1;
    else
        strtoks = strsplit(ch1,':');
        cch = strtoks{2};
        chnum = tname2tnum(cch,chordmode);
        if chnum > 0
            typecount(chnum) = typecount(chnum)+1;
        end
    end
    
    % get next line and append the endtime to the previous line
    tline = fgetl(fr);
    if ischar(tline)
        tokens = strsplit(tline,'\t');
        st2 = tokens{1};
        ch2 = tokens{2};
        ch1 = castJazzLabel(ch1);
        newst1 = strcat(st1,st2,ch1);
        fprintf(fw,'%s\n',[st1 ' ' st2 ' ' ch1]);
    else
        break;
    end
end
    
fclose(fr);
fclose(fw);
end

disp('number of chords:');
disp(nch);
disp('number of inversions:');
disp(ninv);