% transform .lrc format to .lab format

target = './gt/demoartist/demoalbum/a';
in = [target '.gt.lrc'];
out = [target '.lab'];
fr = fopen(in,'r');
fw = fopen(out,'w');
tline = fgetl(fr);
while ischar(tline)
    % this line
    tokens = strsplit(tline,']');
    st = tokens{1};
    st = st(2:end);
    ch = tokens{2};
    ttokens = strsplit(st,':');
    mm = str2double(ttokens{1});
    ss = str2double(ttokens{2});
    sec1 = mm*60 + ss;
    
    disp(ch);
    
    % construct new chord label
    if isempty(ch)
        tline = fgets(fr);
        continue;
    end
    if strcmp(ch,'N')
        newch = ch;
    elseif length(ch) == 1 % major chord
        newch = ch;
    elseif length(ch) == 2 && (strcmp(ch(2),'#') || strcmp(ch(2),'b')) % major chord
        newch = ch;
    elseif ~isempty(strfind(ch,'m/')) %slash chord
        tokens = strsplit(ch,'m/');
        root = note2num(tokens{1});
        bass = note2num(tokens{2});
        qualityList = {'b2','2','b3','3','4','b5','5','b6','6','b7','7'};
        newch = '?';
        for i = 1:1:length(qualityList)
            qual = qualityList{i};
            if root2bass(root,qual) == bass
                newch = [num2note(root) ':min/' qual];
                break;
            end
        end 
    elseif ~isempty(strfind(ch,'/')) %slash chord
        tokens = strsplit(ch,'/');
        root = note2num(tokens{1});
        bass = note2num(tokens{2});
        qualityList = {'b2','2','b3','3','4','b5','5','b6','6','b7','7'};
        newch = '?';
        for i = 1:1:length(qualityList)
            qual = qualityList{i};
            if root2bass(root,qual) == bass
                newch = [num2note(root) '/' qual];
                break;
            end
        end
    elseif strcmp(ch(2),'#') || strcmp(ch(2),'b')
        if strcmp(ch(3:end),'m')
            newch = [ch(1:2) ':' 'min'];
        elseif strcmp(ch(3:end),'m7')
            newch = [ch(1:2) ':' 'min7'];
        elseif strcmp(ch(3:end),'m6')
            newch = [ch(1:2) ':' 'min6'];
        elseif strcmp(ch(3:end),'m7-5')
            newch = [ch(1:2) ':' 'hdim'];
        else
            newch = [ch(1:2) ':' ch(3:end)];
        end
    else
        if strcmp(ch(2:end),'m')
            newch = [ch(1) ':' 'min'];
        elseif strcmp(ch(2:end),'m7')
            newch = [ch(1) ':' 'min7'];
        elseif strcmp(ch(2:end),'m6')
            newch = [ch(1) ':' 'min6'];
        elseif strcmp(ch(2:end),'m7-5')
            newch = [ch(1) ':' 'hdim'];
        else
            newch = [ch(1) ':' ch(2:end)];
        end
    end
    
    % next line
    tline = fgetl(fr);
    tokens = strsplit(tline,']');
    et = tokens{1};
    et = et(2:end);
    ttokens = strsplit(et,':');
    mm = str2double(ttokens{1});
    ss = str2double(ttokens{2});
    sec2 = mm*60 + ss;
    
    fprintf(fw,'%s\n',[num2str(sec1) ' ' num2str(sec2) ' ' newch]);
end
fclose(fr);
fclose(fw);