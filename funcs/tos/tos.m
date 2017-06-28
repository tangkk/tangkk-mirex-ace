% this script performs tests of significance to various results regarding
% the Chapter 3 and 4 of my PhD thesis

close all;
clear;
comptarget = 'min';

% [maj_5, maj_3, maj, ...
%         maj7_5, maj7_3, maj7_7, maj7, ...
%         dom7_5, dom7_3, dom7_b7, dom7, ...
%         min_5, min_b3, min, ...
%         min7_5, min7_b3, min7_b7, min7];
targetseq = {'maj/5', 'maj/3', 'maj', 'maj7/5', 'maj7/3', 'maj7/7', 'maj7', '7/5', '7/3', '7/b7', '7', 'min/5', 'min/b3', 'min', 'min7/5', 'min7/b3', 'min7/b7', 'min7', 'WCSR', 'ACQA'};
compidx = find(strcmp(targetseq,comptarget));

resroot = 'data/cvres/songwise/testing/';
modules={'blstmrnn_ec-JKURB-ns-songwise-800','blstmrnn-JKURB-ns-songwise-800'};

disp(comptarget);
disp(modules);

table = []; % to store the stats to be compared and tested

for t = 1:length(modules)
    table_ = [];
    for fold = 1:5
        table__ = [];
        if strfind(modules{t},'chordino')
            testmodule = modules{t};
        else
            testmodule = [modules{t},'-',num2str(fold)];
        end
        resultpath = [resroot testmodule];

        tmp = dir([resultpath '/' 'results' 'Bass']);
        tmptxt = tmp(4).name;
        suffix = tmptxt(1:end-4);
        testoutseventhsbass = [resultpath '/' 'results' 'MirexSeventhsBass' '/' suffix '.csv'];
        
        fid = fopen(testoutseventhsbass,'r');
        line = fgetl(fid);
        idx = 1;
        while ischar(line)
            if idx < 3
                line = fgetl(fid);
                idx = idx + 1;
                continue;
            end
            toks = strsplit(line,',');

            content = str2double(toks);
            content(isnan(content)) = 0;

            % title
            title = toks(col2idx('A'));

            % overall metrics
            duration = content(col2idx('C'));
            pairwise = content(col2idx('B'));
            correctchords = content(col2idx('D'));

            % no-chord
            nc = content(col2idx('H'));

            % major
            maj_5 = content(col2idx('K'));
            maj_5p = content(col2idx('L'));
            maj_3 = content(col2idx('M'));
            maj_3p = content(col2idx('N'));
            maj = content(col2idx('O'));
            majp = content(col2idx('P'));

            % major7
            maj7_5 = content(col2idx('S'));
            maj7_5p = content(col2idx('T'));
            maj7_3 = content(col2idx('U'));
            maj7_3p = content(col2idx('V'));
            maj7_7 = content(col2idx('W'));
            maj7_7p = content(col2idx('X'));
            maj7 = content(col2idx('Y'));
            maj7p = content(col2idx('Z'));

            % dominant
            dom7_5 = content(col2idx('AC'));
            dom7_5p = content(col2idx('AD'));
            dom7_3 = content(col2idx('AE'));
            dom7_3p = content(col2idx('AF'));
            dom7_b7 = content(col2idx('AG'));
            dom7_b7p = content(col2idx('AH'));
            dom7 = content(col2idx('AI'));
            dom7p = content(col2idx('AJ'));

            % minor
            min_5 = content(col2idx('AM'));
            min_5p = content(col2idx('AN'));
            min_b3 = content(col2idx('AO'));
            min_b3p = content(col2idx('AP'));
            min = content(col2idx('AQ'));
            minp = content(col2idx('AR'));

            % minor7
            min7_5 = content(col2idx('AU'));
            min7_5p = content(col2idx('AV'));
            min7_b3 = content(col2idx('AW'));
            min7_b3p = content(col2idx('AX'));
            min7_b7 = content(col2idx('AY'));
            min7_b7p = content(col2idx('AZ'));
            min7 = content(col2idx('BA'));
            min7p = content(col2idx('BB'));

            % WCSR and ACQA
            cvec = [maj_5, maj_3, maj, ...
                maj7_5, maj7_3, maj7_7, maj7, ...
                dom7_5, dom7_3, dom7_b7, dom7, ...
                min_5, min_b3, min, ...
                min7_5, min7_b3, min7_b7, min7];
            pvec = [maj_5p, maj_3p, majp, ...
                maj7_5p, maj7_3p, maj7_7p, maj7p, ...
                dom7_5p, dom7_3p, dom7_b7p, dom7p, ...
                min_5p, min_b3p, minp, ...
                min7_5p, min7_b3p, min7_b7p, min7p];
            
            WCSR = (cvec*pvec') / 100 + nc; % with N.C.
            ACQA = sum(cvec) / length(cvec); % without N.C

            statlist = [cvec,WCSR,ACQA];
            
            table__ = [table__;statlist(compidx)]; % this is one fold

            line = fgetl(fid);
            idx = idx + 1;
        end
        fclose(fid);
        table_ = [table_;table__]; % this is multiple folds
        
        if strfind(modules{t},'chordino') % no folds for Chordino
            break;
        end
    end
    table = [table,table_]; % this is one module   
end

% perform a Friedman test for significance test
[p,tbl,stats] = friedman(table); % default alpha=0.05
disp(['friedman test - p:',num2str(p)]);
disp(stats);

% perform a Tukey HSD for post-hoc multiple comparison
multcompare(stats); % default alpha=0.05, CType=tukey-hsd
yticklabels(flip(modules));
xlabel(['Friedman test with Tukey HSD: on ' comptarget]);

function cidx = col2idx(col)
if length(col) == 1
    cidx = double(col) - double('A') + 1;
else % assuming the length is 2
    col1 = col(1);
    col2 = col(2);
    cidx = (double(col1) - double('A') + 1) * 26;
    cidx = cidx + (double(col2) - double('A') + 1);
end
end

% indice for J,K,U,R,B (for chord distributions)
% J = [3:8, 110:115, 215:220, 320:325, 425:429];
% K = [9:14, 116:120, 221:225, 326:330, 430:434];
% U = [15:53, 121:158, 226:262, 331:368, 435:472];
% R = [54:73, 159:178, 264:283, 369:388, 473:492];
% B = [74:109, 179:214, 284:319, 389:424, 493:528];
% C = 529:548;

% proportion of different chords in order:
% [maj_5, maj_3, maj, ...
%         maj7_5, maj7_3, maj7_7, maj7, ...
%         dom7_5, dom7_3, dom7_b7, dom7, ...
%         min_5, min_b3, min, ...
%         min7_5, min7_b3, min7_b7, min7];
% Jp = zeros(1,18);
% Kp = zeros(1,18);
% Up = zeros(1,18);
% Rp = zeros(1,18);
% Bp = zeros(1,18);
% Cp = zeros(1,18);

%     disp(['Title=' title]);
%     ret = -1;
%     if sum(J==idx) > 0
%         ret = 0;
%         Jp = Jp + pvec.*duration;
%     elseif sum(K==idx) > 0
%         ret = 1;
%         Kp = Kp + pvec.*duration;
%     elseif sum(U==idx) > 0
%         ret = 2;
%         Up = Up + pvec.*duration;
%     elseif sum(R==idx) > 0
%         ret = 3;
%         Rp = Rp + pvec.*duration;
%     elseif sum(B==idx) > 0
%         ret = 4;
%         Bp = Bp + pvec.*duration;
%     elseif sum(C==idx) > 0
%         ret = 5;
%         Cp = Cp + pvec.*duration;
%     end

% Jp = Jp ./ sum(Jp) * 100;
% Kp = Kp ./ sum(Kp) * 100;
% Up = Up ./ sum(Up) * 100;
% Rp = Rp ./ sum(Rp) * 100;
% Bp = Bp ./ sum(Bp) * 100;
% Cp = Cp ./ sum(Cp) * 100;



