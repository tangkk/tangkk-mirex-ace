% use readtable function to read a csv file into workspace
function [confmat, nconfmat] = computeConfusion(tablepath)

conftab = readtable(tablepath);
load chordnames-inv.mat;
load chordmode-inv.mat;

rownames = [chordnames; 'N'];
colnames = [' ';rownames];


nct = size(chordmode,2);
chordtypes = [chordmode(2,:) 'N'];
ntypes = nct + 1;

confmat = zeros(ntypes,ntypes);

% compute the confusion matrix of all pairs of chord types
for i = 1:ntypes
    display(i);
    % get the chord in row, which is the test label
    cpchord = chordtypes{i};
    
    % cpchord corresponds to row names
    cprows = [];
    for icp = 1:length(rownames)
        chname = rownames{icp};
        if ~strcmp(chname,'N')
            strtoks = strsplit(chname,':');
            chtype = strtoks{2};
        else
            chtype = 'N';
        end
        if strcmp(cpchord, chtype)
            cprows = [cprows icp];
        end
    end
    
    for j = 1:ntypes
        % get the chord in col, which is the gt label
        gtchord = chordtypes{j};
        
        % get the points in confusion table where the two chord types
        % intersect
        
        % gt chord corresponds to col names
        gtcols = [];
        for igt = 2:length(colnames)
            chname = colnames{igt};
            if ~strcmp(chname,'N')
                strtoks = strsplit(chname,':');
                gttype = strtoks{2};
            else
                gttype = 'N';
            end
            if strcmp(gtchord, gttype)
                gtcols = [gtcols igt];
            end
        end
        
        % use cprows and gtcols to collect data
        lencp = length(cprows);
        lengt = length(gtcols);
        
        confval = 0;
        for c = 1:lencp
            ic = cprows(c);
            for g = 1:lengt
                ig = gtcols(g);
                val = table2array(conftab(ic,ig));
                confval = confval + val;
            end
        end
        confmat(i,j) = confval;
    end
end

% transpose so that the rows are refs and cols are tests
confmat = confmat';

% normalized
nconfmat = zeros(size(confmat));
for i = 1:size(confmat,1)
    row = confmat(i,:);
    sr = sum(row);
    row = row./sr;
    nconfmat(i,:) = row;
end


