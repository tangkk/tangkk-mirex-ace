function mirexaceout(mirexaceList)

% first we manually delete all the contents in 'mirexace/' folder
% if the dir does not exist, create it.
acepath = 'mirexace/';
if exist(acepath,'dir') == 0
    mkdir(acepath);
end

acepaths = {}; aceidx = 1;
acepaths{aceidx} = [acepath 'resultsBass/']; aceidx = aceidx + 1;
acepaths{aceidx} = [acepath 'resultsMirexMajMin/']; aceidx = aceidx + 1;
acepaths{aceidx} = [acepath 'resultsMirexMajMinBass/']; aceidx = aceidx + 1;
acepaths{aceidx} = [acepath 'resultsMirexRoot/']; aceidx = aceidx + 1;
acepaths{aceidx} = [acepath 'resultsMirexSevenths/']; aceidx = aceidx + 1;
acepaths{aceidx} = [acepath 'resultsMirexSeventhsBass/']; aceidx = aceidx + 1;
acepaths{aceidx} = [acepath 'resultsSegmentation/']; aceidx = aceidx + 1;

fl = fopen(mirexaceList,'r');
% mirexaceList stores the systems to be compared using jaburgoyne's tool
line = fgetl(fl);
while ischar(line)
    respath = ['res/' line '/'];
    respaths = {}; residx = 1;
    respaths{residx} = [respath 'resultsBass/']; residx = residx + 1;
    respaths{residx} = [respath 'resultsMirexMajMin/']; residx = residx + 1;
    respaths{residx} = [respath 'resultsMirexMajMinBass/']; residx = residx + 1;
    respaths{residx} = [respath 'resultsMirexRoot/']; residx = residx + 1;
    respaths{residx} = [respath 'resultsMirexSevenths/']; residx = residx + 1;
    respaths{residx} = [respath 'resultsMirexSeventhsBass/']; residx = residx + 1;
    respaths{residx} = [respath 'resultsSegmentation/']; residx = residx + 1;
    
    for i = 1:length(respaths)
        targetdir = acepaths{i};
        sourcedir = respaths{i};
        if exist(targetdir,'dir') == 0
            mkdir(targetdir);
        end
        sourcefile = [sourcedir line '.csv'];
        copyfile(sourcefile, targetdir);
        
        % rename the target files
        newline = '';
        if ~isempty(strfind(line,'cnpop-'))
            newline = line(7:end);
        elseif ~isempty(strfind(line,'J-thebeatles-'))
            newline = line(14:end);
        elseif ~isempty(strfind(line,'thebeatles-'))
            newline = line(12:end);
        end
        
        if ~isempty(strfind(newline,'nnhmm'))
            newline = [newline(1:strfind(newline,'nnhmm')-1) 'I'];
        elseif ~isempty(strfind(newline,'-ens'))
            newline = newline;
        elseif ~isempty(strfind(newline,'-'))
            newline = [newline(1:strfind(newline,'-')) 'II'];
        end
        
        movefile([targetdir line '.csv'],[targetdir newline '.csv']);
    end
    
    line = fgetl(fl);
end

fclose(fl);