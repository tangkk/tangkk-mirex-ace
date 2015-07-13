% generate a table containing the overall performance for every albums included in the
% result folder

result = 'res/full-TheBeatles-ccd-0.6-bc';

% # of albums and # of songs in each album
nalbums = 13;
lalbums = [14,28,41,55,69,83,97,110,121,138,151,168,180];

ltable = cell(181,7);
ltable(1,:) = {'Bass','MajMin','MajMinBass','Root','Seventh','SeventhBass','Segmentation'};

mtable = cell(nalbums+1,7);
mtable(1,:) = {'Bass','MajMin','MajMinBass','Root','Seventh','SeventhBass','Segmentation'};

htable = cell(2,7);
htable(1,:) = {'Bass','MajMin','MajMinBass','Root','Seventh','SeventhBass','Segmentation'};

validfoldernames = 'resultsBassresultsMirexMajMinresultsMirexMajMinBassresultsMirexRootresultsMirexSeventhsresultsMirexSeventhsBassresultsSegmentation';

% it's a three folded folder structure
folderlist1 = dir(result);
for i = 3:length(folderlist1)
    folder1 = folderlist1(i);
    folder1name = folder1.name;
    if ~isempty(strfind(validfoldernames,folder1name))
        folderlist2 = dir([result '/' folder1name]);
        for k = 3:length(folderlist2)
            file = folderlist2(k);
            filename = file.name;
            filepath = [result '/' folder1name '/' filename];
            fr = fopen(filepath,'r');
            pairwise = zeros(180,1);
            duration = zeros(180,1); % this is for calculating weighted average
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
                        ltable{fidx - 1, i - 2} = pw;
                    end
                    tline = fgetl(fr);
                    fidx = fidx + 1;
                end
                fclose(fr);
                
                % compute the weighted average for each album
                p1 = pairwise(1:lalbums(1));
                p2 = pairwise(lalbums(1) + 1 : lalbums(2));
                p3 = pairwise(lalbums(2) + 1 : lalbums(3));
                p4 = pairwise(lalbums(3) + 1 : lalbums(4));
                p5 = pairwise(lalbums(4) + 1 : lalbums(5));
                p6 = pairwise(lalbums(5) + 1 : lalbums(6));
                p7 = pairwise(lalbums(6) + 1 : lalbums(7));
                p8 = pairwise(lalbums(7) + 1 : lalbums(8));
                p9 = pairwise(lalbums(8) + 1 : lalbums(9));
                p10 = pairwise(lalbums(9) + 1 : lalbums(10));
                p11 = pairwise(lalbums(10) + 1 : lalbums(11));
                p12 = pairwise(lalbums(11) + 1 : lalbums(12));
                p13 = pairwise(lalbums(12) + 1 : lalbums(13));
                
                d1 = duration(1:lalbums(1));
                d2 = duration(lalbums(1) + 1 : lalbums(2));
                d3 = duration(lalbums(2) + 1 : lalbums(3));
                d4 = duration(lalbums(3) + 1 : lalbums(4));
                d5 = duration(lalbums(4) + 1 : lalbums(5));
                d6 = duration(lalbums(5) + 1 : lalbums(6));
                d7 = duration(lalbums(6) + 1 : lalbums(7));
                d8 = duration(lalbums(7) + 1 : lalbums(8));
                d9 = duration(lalbums(8) + 1 : lalbums(9));
                d10 = duration(lalbums(9) + 1 : lalbums(10));
                d11 = duration(lalbums(10) + 1 : lalbums(11));
                d12 = duration(lalbums(11) + 1 : lalbums(12));
                d13 = duration(lalbums(12) + 1 : lalbums(13));
                
                % deal differently with segmentation results
                if strcmp(folder1name,'resultsSegmentation')
                    mtable{2,i-2} = mean(d1);
                    mtable{3,i-2} = mean(d2);
                    mtable{4,i-2} = mean(d3);
                    mtable{5,i-2} = mean(d4);
                    mtable{6,i-2} = mean(d5);
                    mtable{7,i-2} = mean(d6);
                    mtable{8,i-2} = mean(d7);
                    mtable{9,i-2} = mean(d8);
                    mtable{10,i-2} = mean(d9);
                    mtable{11,i-2} = mean(d10);
                    mtable{12,i-2} = mean(d11);
                    mtable{13,i-2} = mean(d12);
                    mtable{14,i-2} = mean(d13);
                    % for segmentation result, $duration is combined harmonic
                    % hamming distance
                    htable{2,i-2} = mean(duration);
                else
                    mtable{2,i-2} = p1'*d1 / sum(d1);
                    mtable{3,i-2} = p2'*d2 / sum(d2);
                    mtable{4,i-2} = p3'*d3 / sum(d3);
                    mtable{5,i-2} = p4'*d4 / sum(d4);
                    mtable{6,i-2} = p5'*d5 / sum(d5);
                    mtable{7,i-2} = p6'*d6 / sum(d6);
                    mtable{8,i-2} = p7'*d7 / sum(d7);
                    mtable{9,i-2} = p8'*d8 / sum(d8);
                    mtable{10,i-2} = p9'*d9 / sum(d9);
                    mtable{11,i-2} = p10'*d10 / sum(d10);
                    mtable{12,i-2} = p11'*d11 / sum(d11);
                    mtable{13,i-2} = p12'*d12 / sum(d12);
                    mtable{14,i-2} = p13'*d13 / sum(d13);
                    % for segmentation result, $duration is combined harmonic
                    % hamming distance
                    htable{2,i-2} = pairwise'*duration / sum(duration);
                end
                
                
            end

            if k == 4 % process the .txt file
                fclose(fr);
            end
        end
    end
end