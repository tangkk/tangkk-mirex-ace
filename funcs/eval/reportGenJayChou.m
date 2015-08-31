% generate a table containing the overall performance for the result folder

function [ltable, htable] = reportGenJayChou(resultpath)

ltable = cell(30,7); % totally 30 songs
ltable(1,:) = {'Bass','MajMin','MajMinBass','Root','Seventh','SeventhBass','Segmentation'};

htable = cell(2,7);
htable(1,:) = {'Bass','MajMin','MajMinBass','Root','Seventh','SeventhBass','Segmentation'};

validfoldernames = 'resultsBassresultsMirexMajMinresultsMirexMajMinBassresultsMirexRootresultsMirexSeventhsresultsMirexSeventhsBassresultsSegmentation';

% it's a three folded folder structure
folderlist1 = dir(resultpath);
ti = 0;
for i = 3:length(folderlist1)
    folder1 = folderlist1(i);
    folder1name = folder1.name;
    if ~isempty(strfind(validfoldernames,folder1name))
        ti = ti + 1;
        folderlist2 = dir([resultpath '/' folder1name]);
        for k = 3:length(folderlist2)
            file = folderlist2(k);
            filename = file.name;
            filepath = [resultpath '/' folder1name '/' filename];
            fr = fopen(filepath,'r');
            pairwise = zeros(29,1);
            duration = zeros(29,1); % this is for calculating weighted average
            if k == 3 % process the .csv file
                % read the file
                fidx = 1;
                tline = fgetl(fr);
                while ischar(tline)
                    if fidx >= 3
                        tokens1 = strsplit(tline,'",');
                        tokens2 = strsplit(tokens1{2},',');
                        pw = str2double(tokens2{1});
                        dt = str2double(tokens2{2});
                        pairwise(fidx - 2) = pw;
                        duration(fidx - 2) = dt;
                        ltable{fidx - 1, ti} = pw;
                    end
                    tline = fgetl(fr);
                    fidx = fidx + 1;
                end
                fclose(fr);
                
                % deal differently with segmentation results
                if strcmp(folder1name,'resultsSegmentation')
                    % for segmentation result, $duration is combined harmonic
                    % hamming distance
                    htable{2,ti} = mean(duration);
                else
                    % for segmentation result, $duration is combined harmonic
                    % hamming distance
                    htable{2,ti} = pairwise'*duration / sum(duration);
                end
                
                
            end

            if k == 4 % process the .txt file
                fclose(fr);
            end
        end
    end
end