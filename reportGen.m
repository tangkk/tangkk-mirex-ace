% generate a table containing the overall performance for every albums included in the
% result folder

result = 'res/TheBeatles-all-albums-ccd';

rtable = cell(14,8);
rtable(1,:) = {'','Bass','MajMin','MajMinBass','Root','Seventh','SeventhBass','Segmentation'};

% it's a three folded folder structure
folderlist1 = dir(result);
for i = 3:length(folderlist1)
    folder1 = folderlist1(i);
    folder1name = folder1.name;
    folderlist2 = dir([result '/' folder1name]);
    rtable(i-1,1) = {folder1name};
    for j = 3:length(folderlist2)
        folder2 = folderlist2(j);
        folder2name = folder2.name;
        folderlist3 = dir([result '/' folder1name '/' folder2name]);

        k = 4; % select the '.txt' file only
        file = folderlist3(k);
        filename = file.name;
        filepath = [result '/' folder1name '/' folder2name '/' filename];
        fr = fopen(filepath,'r');
        C = textscan(fr, '%s','delimiter', '\n');
        
        % totally there are 7 columns,
        % the column order should be: Bass | MajMin | MajMinBass | Root |
        % Seventh | SeventhBass | Segmentation
        ascore = C{1}{7};
        tokens = strsplit(ascore,':');
        token = tokens{2};
        if j == length(folderlist2) % segmentation result
            rtable(i-1,j-1) = {str2double(token(2:end))};
        else % non-segmentation result
            rtable(i-1,j-1) = {str2double(token(2:end-1))};
        end
        fclose(fr);
    end
end