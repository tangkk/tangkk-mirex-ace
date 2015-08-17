% write out the chord progression as txt file according to the MIREX
% standard: http://www.music-ir.org/mirex/wiki/2015:Audio_Chord_Estimation
function writeOut(outpath, hopsize, fs,...
    rootgram, treblegram, bdrys, endtime, chordmode)

nslices = size(rootgram,2);

fw = fopen(outpath,'w');
formatSpec = '%s\n';
tw = ((hopsize/fs)*(0:bdrys(end)));

% add non-chord before start if needed
if bdrys(1) ~= 1
    sec0 = tw(bdrys(1));
    timestr0 = num2str(sec0);
    s = ['0', ' ', timestr0, ' ', 'N'];
    fprintf(fw, formatSpec, s);
end

for i = 1:1:nslices
    sec1 = tw(bdrys(i));
    timestr1 = num2str(sec1);
    sec2 = tw(bdrys(i+1));
    timestr2 = num2str(sec2);
    root = rootgram(i);
    treble = treblegram(i);
    if root ~= 0 || treble ~= 0
        chordstr = strcat(num2note(root), ':', chordmode{2,treble});
    else
        chordstr = 'N';
    end
    s = [timestr1, ' ', timestr2, ' ', chordstr];
    fprintf(fw, formatSpec, s);
end

% add non-chord after finish if needed
if sec2 ~= endtime
    sec3 = endtime;
    timestr3 = num2str(sec3);
    s = [timestr2, ' ', timestr3, ' ', 'N'];
    fprintf(fw, formatSpec, s);
end

fclose(fw);