fid = fopen('JazzBook99List.txt','w');
formatSpec = '%s\r\n';
for i = 1:99
    n = num2str(i);
    str = ['JazzBook/T' n '.mp3'];
    fprintf(fid,formatSpec,str);
end
fclose(fid);


