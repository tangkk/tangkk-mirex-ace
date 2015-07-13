% transform sonic-visualizer annotation output .txt to .lab that can be recognized by
% evaluation tools

target = './gt/variousartist/inversions/test';
in = [target '.txt'];
out = [target '.lab'];
fr = fopen(in,'r');
fw = fopen(out,'w');

tline = fgetl(fr);
while ischar(tline)
    tokens = strsplit(tline,'\t');
    st1 = tokens{1};
    ch1 = tokens{2};
    
    disp(ch1);
    
    % get next line and append the endtime to the previous line
    tline = fgetl(fr);
    if ischar(tline)
        tokens = strsplit(tline,'\t');
        st2 = tokens{1};
        ch2 = tokens{2};

        newst1 = strcat(st1,st2,ch1);
        fprintf(fw,'%s\n',[st1 ' ' st2 ' ' ch1]);
    else
        break;
    end
end
    
fclose(fr);
fclose(fw);