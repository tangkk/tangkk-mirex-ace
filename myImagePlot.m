% plot various gram as an image with a scaling factor
function myImagePlot(img, x, y, xl, yl, tit, ytl, ytlab)
sfactor = 100;
if nargin == 6
    figure;
    image(x,y,sfactor*img);
    set(gca,'YDir','normal');
    xlabel(xl);
    ylabel(yl);
    title(tit);
end
if nargin == 8
    figure;
    image(x,y,sfactor*img);
    set(gca,'YDir','normal');
    xlabel(xl);
    ylabel(yl);
    set(gca, 'YTick',ytl, 'YTickLabel', ytlab);
    title(tit);
end