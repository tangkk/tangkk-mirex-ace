function visualizeChordProgression(rootgram, bassgram, treblegram, bdrys, chordmode)

nchords = length(rootgram);

scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
hold on;
Y = -10:0.1:10;
for i = 1:1:length(bdrys)
    X = bdrys(1,i)*ones(size(Y));
    plot(X,Y);
end
hold off;
div = (max(Y) - min(Y) - 1) / nchords;
for i = 1:1:nchords
    x = bdrys(i);
    ch = strcat(num2note(rootgram(i)),':',chordmode{2,treblegram(i)});
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