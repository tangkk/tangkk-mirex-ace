% this function generate an N-fold cross-validation split of the incoming
% list (i.e. split the incoming list to N-fold)

function cvListGen(inList,N)

cvList = {};
fcv = [];
for i = 1:N
    aList = [inList(1:end-4) '-' num2str(i) '.txt'];
    cvList = [cvList; aList];
    fa = fopen(aList,'w');
    fcv = [fcv; fa];
end


fe = fopen(inList,'r');
tline = fgetl(fe);
linecount = 0;
FORMAT = '%s\n';
while ischar(tline)
    disp(tline);
    fs = mod(linecount,5) + 1;
    fprintf(fcv(fs),FORMAT,tline);
    
    linecount = linecount + 1;
    tline = fgetl(fe);
end

fclose(fe);

for i = 1:N
    fclose(fcv(i));
end