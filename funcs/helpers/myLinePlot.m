function myLinePlot(x, y, xlab, ylab, xl, yl, marker, tit, ytl, ytlab)
if nargin == 8
    figure;
    plot(x,y,marker);
    xlim([1 xl]);
    ylim([1 yl]);
    xlabel(xlab);
    ylabel(ylab);
    title(tit);
end
if nargin == 10
    figure;
    plot(x,y,marker);
    xlim([1 xl]);
    ylim([1 yl]);
    xlabel(xlab);
    ylabel(ylab);
    set(gca, 'YTick',ytl, 'YTickLabel', ytlab);
    title(tit);
end