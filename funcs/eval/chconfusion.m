% compute simple statistics of the chord confusion matrix
clear;

confpath = './out/resultsMirexSeventhsBass/jaychou-10.con.csv';
fr = fopen(confpath,'r');
conf = cell(1,1); % compute 4-th order
linenum = 0;
load('chordnames.mat');
revconf = cell(length(chordnames),20);
revconf(:,1) = chordnames;
tline = fgetl(fr); 
while ischar(tline)
    if linenum == 0
        % first row stores the chord names
        strtoks = strsplit(tline,{',','"'});
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
            conf{linenum,1} = strtoks{1}(2:end-1);
            conf(linenum,2:2:2+2*3) = chNames(I(1:4));
            conf(linenum,3:2:3+2*3) = strtoks(I(1:4)+1);
            
            % reverse conf matrix
            confhead = conf{linenum,1};
            conftails = conf(linenum,2:2:2+2*3); % totally 4 tails
            for j = 1:4
                conftail = conftails{j};
                if ~strcmp(confhead, conftail)
                    [ismem,loc] = ismember(conftail, chordnames);
                    if ismem
                        for k = 1:20
                            if isempty(revconf{loc,k})
                                revconf{loc,k} = confhead;
                                break;
                            end
                        end
                        
                    end
                end
            end
            
            linenum = linenum + 1;
        end
    end
    tline = fgetl(fr);
end

fclose(fr);

save('revconf.mat','revconf');