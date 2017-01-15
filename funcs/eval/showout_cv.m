% show the outputs

function showout_cv(evList)


mmtable_cv = cell(1,2);
mmbtable_cv = cell(1,6);
stable_cv = cell(1,5);
sbtable_cv = cell(1,18);
nctable_cv = cell(1,1);
os_cv = cell(1,7);
evaltable_cv = cell(1,1);
loopidx_cv = 1;

frpl = fopen(evList,'r');
evalmodule_ = fgetl(frpl);

while ischar(evalmodule_)
    mmtable = cell(1,2);
    mmbtable = cell(1,6);
    stable = cell(1,5);
    sbtable = cell(1,18);
    nctable = cell(1,1);
    os = cell(1,7);
    evaltable = cell(1,1);
    
    loopidx = 1;
    
    for fold = 1:5
        ncpern = 100;
        evalmodule = [evalmodule_,'-',num2str(fold)];
        resultpath = ['res/' evalmodule];
        evaltable{loopidx+2,:} = evalmodule;

        tmp = dir([resultpath '/' 'results' 'Bass']);
        tmptxt = tmp(4).name;
        suffix = tmptxt(1:end-4);

        evaloutseg = [resultpath '/' 'results' 'Segmentation' '/' suffix '.txt'];
        evaloutbass = [resultpath '/' 'results' 'Bass' '/' suffix '.txt'];
        evaloutroot = [resultpath '/' 'results' 'MirexRoot' '/' suffix '.txt'];
        evaloutmajmin = [resultpath '/' 'results' 'MirexMajMin' '/' suffix '.txt'];
        evaloutmajminbass = [resultpath '/' 'results' 'MirexMajMinBass' '/' suffix '.txt'];
        evaloutsevenths = [resultpath '/' 'results' 'MirexSevenths' '/' suffix '.txt'];
        evaloutseventhsbass = [resultpath '/' 'results' 'MirexSeventhsBass' '/' suffix '.txt'];

        dbtype(evaloutbass,'3:7');
        dbtype(evaloutroot,'3:7');
        dbtype(evaloutroot,'15');
        dbtype(evaloutmajmin,'3:7');
        dbtype(evaloutmajmin,'17:20');
        dbtype(evaloutmajminbass,'3:7');
        dbtype(evaloutmajminbass,'17:26');
        dbtype(evaloutsevenths,'3:7');
        dbtype(evaloutsevenths,'17:23');
        dbtype(evaloutseventhsbass,'3:7');
        dbtype(evaloutseventhsbass,'17:41');
        dbtype(evaloutseg,'3:7');

        disp(suffix);

        % save the Bass percentage
        fr = fopen(evaloutroot,'r');
        tline = fgetl(fr);
        li = 1;

        while ischar(tline)
            if li == 7
                strtoks1 = strsplit(tline,':');
                per = strtoks1{2};
                rootscore = str2double(per(2:end-1)); % delete the '%' symbol
            end
            if li == 15
                strtoks1 = strsplit(tline,':');
                strtoks2 = strsplit(strtoks1{2},{'(',')'});
                per = strtoks2{2};
                dper = str2double(per(1:end-1)); % delete the '%' symbol
                nc = dper;
                nctable{loopidx,:} = nc;
            end
            tline = fgetl(fr);
            li = li+1;
        end
        fclose(fr);

        % save the Bass percentage
        fr = fopen(evaloutbass,'r');
        tline = fgetl(fr);
        li = 1;
        while ischar(tline)
            if li >= 7 && li <= 7
                strtoks1 = strsplit(tline,':');
                per = strtoks1{2};
                bassscore = str2double(per(2:end-1)); % delete the '%' symbol
            end
            tline = fgetl(fr);
            li = li+1;
        end
        fclose(fr);

        % save the majmin output to a table for recording
        fr = fopen(evaloutmajmin,'r');
        tline = fgetl(fr);
        li = 1;
        while ischar(tline)
            if li == 7
                strtoks1 = strsplit(tline,':');
                per = strtoks1{2};
                majminscore = str2double(per(2:end-1)); % delete the '%' symbol
            end
            if li >= 19 && li <= 20
                strtoks1 = strsplit(tline,':');
                ch = strtoks1{1};
                strtoks2 = strsplit(strtoks1{2},{'(',')'});
                per = strtoks2{2};
                dper = str2double(per(1:end-1)); % delete the '%' symbol
                tol = strtoks2{4};
                if loopidx == 1
                    mmtable{loopidx, li - 18} = ch;
                    mmtable{loopidx+1, li - 18} = tol;
                    mper = str2double(tol(1:end-1));
                    ncpern = ncpern - mper;
                end
                mmtable{loopidx+2, li - 18} = dper;

            end
            tline = fgetl(fr);
            li = li+1;
        end
        fclose(fr);

        % save the majminbass output to a table for recording
        fr = fopen(evaloutmajminbass,'r');
        tline = fgetl(fr);
        li = 1;
        ti = 1;

        while ischar(tline)
            if li == 7
                strtoks1 = strsplit(tline,':');
                per = strtoks1{2};
                majminbassscore = str2double(per(2:end-1)); % delete the '%' symbol
            end
            if li >= 19 && li <= 26
                strtoks1 = strsplit(tline,':');
                ch = strtoks1{1};
                if ~isempty(strfind(ch,'/1'))
                    tline = fgetl(fr);
                    li = li+1;
                    continue;
                end
                strtoks2 = strsplit(strtoks1{2},{'(',')'});
                per = strtoks2{2};
                dper = str2double(per(1:end-1)); % delete the '%' symbol
                tol = strtoks2{4};
                if loopidx == 1
                    mmbtable{loopidx, ti - 18} = ch;
                    mmbtable{loopidx+1, ti - 18} = tol;
                end
                mmbtable{loopidx+2, ti - 18} = dper;

            end
            tline = fgetl(fr);
            li = li+1;
            ti = ti+1;
        end
        fclose(fr);

        % save the sevenths output to a table for recording
        fr = fopen(evaloutsevenths,'r');
        tline = fgetl(fr);
        li = 1;

        while ischar(tline)
            if li == 7
                strtoks1 = strsplit(tline,':');
                per = strtoks1{2};
                seventhsscore = str2double(per(2:end-1)); % delete the '%' symbol
            end
            if li >= 19 && li <= 23
                strtoks1 = strsplit(tline,':');
                ch = strtoks1{1};
                strtoks2 = strsplit(strtoks1{2},{'(',')'});
                per = strtoks2{2};
                dper = str2double(per(1:end-1)); % delete the '%' symbol
                tol = strtoks2{4};
                if loopidx == 1
                    stable{loopidx, li - 18} = ch;
                    stable{loopidx+1, li - 18} = tol;
                end
                stable{loopidx+2, li - 18} = dper;

            end
            tline = fgetl(fr);
            li = li+1;
        end
        fclose(fr);

        % save the seventhsbass output to a table for recording
        fr = fopen(evaloutseventhsbass,'r');
        tline = fgetl(fr);
        li = 1;
        ti = 1;

        while ischar(tline)
            if li == 7
                strtoks1 = strsplit(tline,':');
                per = strtoks1{2};
                seventhsbassscore = str2double(per(2:end-1)); % delete the '%' symbol
            end
            if li >= 19 && li <= 41
                strtoks1 = strsplit(tline,':');
                ch = strtoks1{1};
                if ~isempty(strfind(ch,'/1'))
                    tline = fgetl(fr);
                    li = li+1;
                    continue;
                end
                strtoks2 = strsplit(strtoks1{2},{'(',')'});
                per = strtoks2{2};
                dper = str2double(per(1:end-1)); % delete the '%' symbol
                tol = strtoks2{4};
                if loopidx == 1
                    sbtable{loopidx, ti - 18} = ch;
                    sbtable{loopidx+1, ti - 18} = tol;
                end
                sbtable{loopidx+2, ti - 18} = dper;

            end
            tline = fgetl(fr);
            li = li+1;
            ti = ti+1;
        end
        fclose(fr);

        % save the Segmentation percentage
        fr = fopen(evaloutseg,'r');
        tline = fgetl(fr);
        li = 1;
        while ischar(tline)
            if li >= 11 && li <= 11
                strtoks1 = strsplit(tline,':');
                per = strtoks1{2};
                segmentationscore = 100*str2double(per(2:end)); % delete the '%' symbol
            end
            tline = fgetl(fr);
            li = li+1;
        end
        fclose(fr);

        if loopidx == 1
            os(loopidx,:) = {'Bass', 'MajMin', 'MajMinBass', 'Root', 'Seventh', 'SeventhBass', 'Segmentation'};
        end
        os(loopidx+2,:) = {bassscore, majminscore, majminbassscore, rootscore, seventhsscore, seventhsbassscore, segmentationscore};

        
        loopidx = loopidx + 1;
    end
    
    assignin('base', 'evaltable',evaltable);
    assignin('base', 'nctable', nctable);
    assignin('base', 'mm', mmtable);
    assignin('base', 'mmb', mmbtable);
    assignin('base', 's', stable);
    assignin('base', 'sb', sbtable);
    tablelen = size(mmtable,1);
    ncperstr = [num2str(ncpern) '%'];
    assignin('base', 'all', [sbtable,cell(tablelen,1),stable,cell(tablelen,1),mmbtable,cell(tablelen,1),mmtable,cell(tablelen,1),['nc';ncperstr;nctable]]);
    assignin('base', 'os', os);
    
    evaltable_cv{loopidx_cv,:} = evalmodule_;
    temp = mean(cell2num(nctable(3:end,:)));
    temp(isnan(temp)) = 0;
    nctable_cv(loopidx_cv,:) = num2cell(temp);
    temp = mean(cell2num(mmtable(3:end,:)));
    temp(isnan(temp)) = 0;
    mmtable_cv(loopidx_cv,:) = num2cell(temp);
    temp = mean(cell2num(mmbtable(3:end,:)));
    temp(isnan(temp)) = 0;
    mmbtable_cv(loopidx_cv,:) = num2cell(temp);
    temp = mean(cell2num(stable(3:end,:)));
    temp(isnan(temp)) = 0;
    stable_cv(loopidx_cv,:) = num2cell(temp);
    temp = mean(cell2num(sbtable(3:end,:)));
    temp(isnan(temp)) = 0;
    sbtable_cv(loopidx_cv,:) = num2cell(temp);
    temp = mean(cell2num(os(3:end,:)));
    temp(isnan(temp)) = 0;
    os_cv(loopidx_cv,:) = num2cell(temp);
    
    evalmodule_ = fgetl(frpl);
    loopidx_cv = loopidx_cv + 1;
end

assignin('base', 'evaltable_cv',evaltable_cv);
assignin('base', 'nctable_cv', nctable_cv);
assignin('base', 'mm_cv', mmtable_cv);
assignin('base', 'mmb_cv', mmbtable_cv);
assignin('base', 's_cv', stable_cv);
assignin('base', 'sb_cv', sbtable_cv);
tablelen_cv = size(mmtable_cv,1);
assignin('base', 'all_cv', [sbtable_cv,cell(tablelen_cv,1),stable_cv,cell(tablelen_cv,1),mmbtable_cv,cell(tablelen_cv,1),mmtable_cv,cell(tablelen_cv,1),nctable_cv]);
assignin('base', 'os_cv', os_cv);

fclose(frpl);
