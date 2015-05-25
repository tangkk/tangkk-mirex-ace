function visualizeTonicProgression(tonicSeq, bdrys)

ntonics = length(tonicSeq);

scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
hold on;
Y = -10:0.1:10;
for i = 1:1:length(bdrys)
    X = bdrys(1,i)*ones(size(Y));
    plot(X,Y);
end
hold off;
div = (max(Y) - min(Y) - 1) / ntonics;
for i = 1:1:ntonics
    x = bdrys(i);
    tonic = tonicSeq{i};
    text(x,10 - i*div,tonic);
end
xlabel('slice');
ylabel('tonic');
title('tonic vs. slice');