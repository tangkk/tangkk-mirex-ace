% compute simple statistics of the chord confusion matrix
clear;

confpath = './out/resultsMirexSeventhsBass/jaychou-10.con.csv';
fr = fopen(confpath,'r');
res = cell(1,1); % compute 4-th order
linenum = 0;
tline = fgetl(fr);
while ischar(tline)
    if linenum == 0
        % first row stores the chord names
        strtoks = strsplit(tline,',');
        chNames = strtoks(2:end);
        linenum = linenum + 1;
    else
        strtoks = strsplit(tline,',');
        stats = zeros(1,length(strtoks)-1);
        for i = 2:length(strtoks)
            stats(i-1) = str2double(strtoks{i});
        end
        [S,I] = sort(stats,'descend');
        if S(1) ~= 0
            res{linenum,1} = strtoks{1};
            res(linenum,2:2:2+2*4) = chNames(I(1:5));
            res(linenum,3:2:3+2*4) = strtoks(I(1:5)+1);
            linenum = linenum + 1;
        end
    end
    tline = fgetl(fr);
end

fclose(fr);