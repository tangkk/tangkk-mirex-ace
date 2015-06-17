% plot various gram as an image with a scaling factor
function myImagePlot(img, x, y, xl, yl, tit, ytl, ytlab)
sfactor = 200;
img = sfactor * globalNormalize(img);
if nargin == 6
    scrsz = get(groot,'ScreenSize');
    figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    image(x,y,img);
    set(gca,'YDir','normal');
    xlabel(xl);
    ylabel(yl);
    title(tit);
end
if nargin == 8
    scrsz = get(groot,'ScreenSize');
    figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    image(x,y,img);
    set(gca,'YDir','normal');
    xlabel(xl);
    ylabel(yl);
    set(gca, 'YTick',ytl, 'YTickLabel', ytlab);
    title(tit);
end