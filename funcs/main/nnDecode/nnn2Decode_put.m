% work with TheanoNN
function [rootgram, bassgram, treblegram] = nnn2Decode_put(tline, rawbasegram, rawuppergram, bdrys, nseg)

rootgram = [];
bassgram = [];
treblegram = [];

nslices = size(bdrys,2)-1;

% step 1, generate the nseg samples from rawbasegram and rawuppergram - store X
X = zeros(1,24*nseg);
for j = 1:nslices
    sb = bdrys(j);
    eb = bdrys(j+1);
    smb = rawbasegram(:,sb:eb);
    smu = rawuppergram(:,sb:eb);
    sm = [smb;smu];
    smnseg = zeros(24,nseg);

    % seperate each segment into nseg sections (along time axis) and take average upon the
    % segments
    lenseg = eb-sb+1; % length of the whole segment
    lensec = max(floor(lenseg / nseg),1); % length of each section
    for i = 1:nseg
        smsec = mean(sm(:,min((i-1)*lensec+1,lenseg): min(i*lensec,lenseg)),2);
        smnseg(:,i) = smsec;
    end
    tcase = smnseg(:);
    X(j,:) = tcase';
end

tline = strrep(tline(1:end-4),'/','-');
savename = ['./data/x/', tline, '-ch', '-', num2str(nseg), 'seg.mat'];

save(savename,'X');


