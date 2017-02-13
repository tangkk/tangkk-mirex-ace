% work with TheanoNN
function nnn6Decode_put(tline, ns, bdrys, nseg)

nslices = size(bdrys,2)-1;
% nseg = 6;

% step 1, generate the 6seg samples from rawbasegram and rawuppergram - store X
X = zeros(1,252*nseg);
for j = 1:nslices
    sb = bdrys(j);
    eb = bdrys(j+1);
    sm = ns(:,sb:eb);
    smnseg = zeros(252,nseg);

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
savename = ['./data/x/', tline, '-ns', '-', num2str(nseg), 'seg.mat'];

save(savename,'X');