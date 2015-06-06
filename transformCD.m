% transform chordino output .lab to the .txt that can be recognized by
% evaluation tools

target = './cd/TheBeatles/01_-_Please_Please_Me';

files = dir(target);

for i = 3:size(files,1)

filename = files(i).name;
filename = filename(1:end-4);
fpath = [target '/' filename];

in = [fpath '.lab'];
out = [fpath '.txt'];
fr = fopen(in,'r');
fw = fopen(out,'w');
tline = fgetl(fr);
while ischar(tline)
    tokens = strsplit(tline,'\t');
    st = tokens{1};
	et = tokens{2};
    ch = tokens{3};
    
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
    elseif ~isempty(strfind(ch,'dim7/')) %slash chord
        tokens = strsplit(ch,'dim7/');
        root = note2num(tokens{1});
        bass = note2num(tokens{2});
        qualityList = {'b2','2','b3','3','4','b5','5','b6','6','b7','7'};
        newch = '?';
        for i = 1:1:length(qualityList)
            qual = qualityList{i};
            if root2bass(root,qual) == bass
                newch = [num2note(root) ':dim7/' qual];
                break;
            end
        end
    elseif ~isempty(strfind(ch,'maj7/')) %slash chord
        tokens = strsplit(ch,'maj7/');
        root = note2num(tokens{1});
        bass = note2num(tokens{2});
        qualityList = {'b2','2','b3','3','4','b5','5','b6','6','b7','7'};
        newch = '?';
        for i = 1:1:length(qualityList)
            qual = qualityList{i};
            if root2bass(root,qual) == bass
                newch = [num2note(root) ':maj7/' qual];
                break;
            end
        end
    elseif ~isempty(strfind(ch,'min7/')) %slash chord
        tokens = strsplit(ch,'min7/');
        root = note2num(tokens{1});
        bass = note2num(tokens{2});
        qualityList = {'b2','2','b3','3','4','b5','5','b6','6','b7','7'};
        newch = '?';
        for i = 1:1:length(qualityList)
            qual = qualityList{i};
            if root2bass(root,qual) == bass
                newch = [num2note(root) ':min7/' qual];
                break;
            end
        end
    elseif ~isempty(strfind(ch,'7/')) %slash chord
        tokens = strsplit(ch,'7/');
        root = note2num(tokens{1});
        bass = note2num(tokens{2});
        qualityList = {'b2','2','b3','3','4','b5','5','b6','6','b7','7'};
        newch = '?';
        for i = 1:1:length(qualityList)
            qual = qualityList{i};
            if root2bass(root,qual) == bass
                newch = [num2note(root) ':7/' qual];
                break;
            end
        end
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
        elseif strcmp(ch(3:end),'6')
            newch = [ch(1:2) ':' 'maj6'];
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
        elseif strcmp(ch(2:end),'6')
            newch = [ch(1) ':' 'maj6'];
        else
            newch = [ch(1) ':' ch(2:end)];
        end
    end
    
    tline = fgetl(fr);
    
    fprintf(fw,'%s\n',[st ' ' et ' ' newch]);
end
fclose(fr);
fclose(fw);

end