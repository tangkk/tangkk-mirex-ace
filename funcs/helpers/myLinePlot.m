function myLinePlot(x, y, xlab, ylab, xl, yl, marker, tit, ytl, ytlab)
if xl > 1
if nargin == 8
    scrsz = get(groot,'ScreenSize');
    figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    plot(x,y,marker);
    xlim([1 xl]);
    ylim([1 yl]);
    xlabel(xlab);
    ylabel(ylab);
    title(tit);
end
if nargin == 10
    scrsz = get(groot,'ScreenSize');
    figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    plot(x,y,marker);
    xlim([1 xl]);
    ylim([1 yl]);
    xlabel(xlab);
    ylabel(ylab);
    set(gca, 'YTick',ytl, 'YTickLabel', ytlab);
    title(tit);
end
end