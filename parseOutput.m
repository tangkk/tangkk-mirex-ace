function [bassgram, treblegram, treblenames, boundaries] = parseOutput(path)

bassgram = [];
treblegram = [];
treblenames = {};
boundaries = [];

fr = fopen(path,'r');
tline = fgets(fr);
while ischar(tline) && length(tline) > 1
    tokens = strsplit(tline);
    st = tokens{1};
    et = tokens{2};
    ch = tokens{3};
    % delete the '\n' char at the end
    ch = ch(1:end-1);
    
    % parse bass and treble
    [bass,treble] = parseBassTreble(ch);
    
    % transform treble to built-in way
    treblenames = [treblenames treble];
    trebletype = trebleTypeMapping(treble);
    bassgram = [bassgram bass];
    treblegram = [treblegram trebletype];
    
    % parse seconds
    sec = str2double(st);
    boundaries = [boundaries sec];
    tline = fgets(fr);
end

% parse the end time
esec = str2double(et);
boundaries = [boundaries esec];

fclose(fr);
