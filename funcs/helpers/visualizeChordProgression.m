function visualizeChordProgression(rootgram, bassgram, treblegram, bdrys, chordmode)

nslices = length(rootgram);

scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
hold on;
Y = -10:0.1:10;
for i = 1:1:length(bdrys)
    X = bdrys(1,i)*ones(size(Y));
    plot(X,Y);
end
hold off;
div = (max(Y) - min(Y) - 1) / nslices;
for i = 1:1:nslices
    x = bdrys(i);
    root = rootgram(i);
    treble = treblegram(i);
    if root ~= 0 || treble ~= 0
        ch = strcat(num2note(root),':',chordmode{2,treble});
    else
        ch = 'N';
    end
    if isempty(strfind(ch, '/'))
        chordstr = ch;
        text(x,10 - i*div,chordstr);
    else
        originchordstr = strsplit(ch,'/');
        treble = originchordstr{1};
        bassstr = num2note(bassgram(i));
        chordstr = strcat(treble, '/', bassstr);
        text(x,10 - i*div,chordstr);
    end
end
xlabel('slice');
ylabel('chord');
title('chordprogression vs. slice');