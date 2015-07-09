% write out the chord progression as txt file according to the MIREX
% standard: http://www.music-ir.org/mirex/wiki/2015:Audio_Chord_Estimation
function writeChordProgression(outfolder, outpath, nslices, hopsize, fs,...
    rootgram, treblegram, bdrys, endtime, chordmode)

if exist(outfolder, 'file') == 0
    mkdir(outfolder);
end

fw = fopen(outpath,'w');
formatSpec2 = '%s\n';
tw = ((hopsize/fs)*(0:nslices));

% add non-chord before start if needed
if bdrys(1) ~= 1
    sec0 = tw(bdrys(1));
    timestr0 = num2str(sec0);
    s = ['0', ' ', timestr0, ' ', 'N'];
    fprintf(fw, formatSpec2, s);
end

nslices = size(rootgram,2);
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
    fprintf(fw, formatSpec2, s);
end

% add non-chord after finish if needed
if sec2 ~= endtime
    sec3 = endtime;
    timestr3 = num2str(sec3);
    s = [timestr2, ' ', timestr3, ' ', 'N'];
    fprintf(fw, formatSpec2, s);
end

fclose(fw);