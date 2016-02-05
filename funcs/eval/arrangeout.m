function arrangeout(path1)

list1 = dir(path1);
dnames1 = {};
for i=3:length(list1)
    dnames1{i-2} = list1(i).name;
end

respath = 'res/';
for i=1:length(dnames1)
    mname = dnames1{i};
    path2 = [path1 mname '/'];
    list2 = dir(path2);
    for j=3:length(list2)
        rawname = list2(j).name;
        
        dotpos = strfind(rawname,'.');
        fname = rawname(1:dotpos(1)-1);
        resfpath = [respath fname '/' mname '/'];
        if exist(resfpath,'dir') == 0
            % if result folder does not exist make folder
            mkdir(resfpath);
        end
        % copy the files
        sourcepath = [path2 rawname];
        despath = resfpath;
        copyfile(sourcepath, despath);
    end
end