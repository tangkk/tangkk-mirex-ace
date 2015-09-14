% this script generate three data sets based on the input-chordnum data set
% the three data sets are input-bass, input-root, and input-chordtype data
% sets.

function brtGen(in, saveroot, savetreble, savebass)

data = load(in);
load chordnames.mat;
chordmode =  chordTypesGen;
chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];
% X doesn't need to be modified. Only y is modified
y = data.y;
X = data.X;
m = size(y,1);

yr = zeros(size(y));
yt = zeros(size(y));
yb = zeros(size(y));
% for every entry of y, decide bass, root and treble type entry
for i = 1:m
    chnum = chordnums{y(i)};
    strtoks = strsplit(chnum,':');
    root = str2double(strtoks{1});
    treble = str2double(strtoks{2});
    if treble == 0
        bass = root;
    else
        bass = root2bass(root,chordmode{2,treble});
    end
    yr(i) = root;
    yt(i) = treble;
    yb(i) = bass;
end
yr(yr == 0) = 13;
yt(yt == 0) = size(chordmode,2)+1;
yb(yb == 0) = 13;
save(saveroot,'X','yr');
save(savetreble,'X','yt');
save(savebass,'X','yb');
