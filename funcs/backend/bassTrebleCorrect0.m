% correct the bassgram based on the first 1/8 of the harmonic regions of
% the basegram, and update rootgram and treblegram accordingly.
% The dominant bass of the 1/8 of
% the harmonic stable region will be the chord bass of the whole harmonic
% region

function [rootgram, bassgram, treblegram] = bassTrebleCorrect0(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode)

nslices = size(rootgram,2);

% bass decision boundary = 1/8 of the harmonic stable region, which is a
% reasonable value intuitively. It means the dominant bass of the 1/8 of
% the harmonic stable region will be the chord bass of the whole harmonic
% region
bdb = 1/8;

tmaj = chordmode{1, tname2tnum('maj', chordmode)};
tmin = chordmode{1, tname2tnum('min', chordmode)};
tmajon3 = chordmode{1, tname2tnum('maj/3', chordmode)};
tmajon5 = chordmode{1, tname2tnum('maj/5', chordmode)};
tminonb3 = chordmode{1, tname2tnum('min/b3', chordmode)};
tminon5 = chordmode{1, tname2tnum('min/5', chordmode)};
tmaj7 = chordmode{1, tname2tnum('maj7', chordmode)};
tmin7 = chordmode{1, tname2tnum('min7', chordmode)};
t7 = chordmode{1, tname2tnum('7', chordmode)};
tmaj7on3 = chordmode{1, tname2tnum('maj7/3', chordmode)};
tmaj7on5 = chordmode{1, tname2tnum('maj7/5', chordmode)};
tmaj7on7 = chordmode{1, tname2tnum('maj7/7', chordmode)};
tmin7onb3 = chordmode{1, tname2tnum('min7/b3', chordmode)};
tmin7on5 = chordmode{1, tname2tnum('min7/5', chordmode)};
tmin7onb7 = chordmode{1, tname2tnum('min7/b7', chordmode)};
t7on3 = chordmode{1, tname2tnum('7/3', chordmode)};
t7on5 = chordmode{1, tname2tnum('7/5', chordmode)};
t7onb7 = chordmode{1, tname2tnum('7/b7', chordmode)};

wmaj = chordmode{3, tname2tnum('maj', chordmode)};
wmin = chordmode{3, tname2tnum('min', chordmode)};
wmaj7 = chordmode{3, tname2tnum('maj7', chordmode)};
wmin7 = chordmode{3, tname2tnum('min7', chordmode)};
w7 = chordmode{3, tname2tnum('7', chordmode)};
wmajon3 = chordmode{3, tname2tnum('maj/3', chordmode)};
wmajon5 = chordmode{3, tname2tnum('maj/5', chordmode)};
wminonb3 = chordmode{3, tname2tnum('min/b3', chordmode)};
wminon5 = chordmode{3, tname2tnum('min/5', chordmode)};
wmaj7on3 = chordmode{3, tname2tnum('maj7/3', chordmode)};
wmaj7on5 = chordmode{3, tname2tnum('maj7/5', chordmode)};
wmaj7on7 = chordmode{3, tname2tnum('maj7/7', chordmode)};
wmin7onb3 = chordmode{3, tname2tnum('min7/b3', chordmode)};
wmin7on5 = chordmode{3, tname2tnum('min7/5', chordmode)};
wmin7onb7 = chordmode{3, tname2tnum('min7/b7', chordmode)};
w7on3 = chordmode{3, tname2tnum('7/3', chordmode)};
w7on5 = chordmode{3, tname2tnum('7/5', chordmode)};
w7onb7 = chordmode{3, tname2tnum('7/b7', chordmode)};

narr = {'maj', 'min', 'maj7', 'min7', '7', 'maj/3', 'maj/5',...
    'min/b3', 'min/5', 'maj7/3', 'maj7/5', 'maj7/7', 'min7/b3', 'min7/5', 'min7/b7', '7/3', '7/5', '7/b7'};

for j = 1:nslices
    bd1 = bdrys(j);
    bd2 = bdrys(j+1);
    % hsr = bd1:bd2; % harmonic stable region
    hsrbdb = bd1:min(bd1 + floor((bd2 - bd1 + 1)*bdb), bd2);
    bgbdb = basegram(:,hsrbdb);
    ugbdb = uppergram(:,hsrbdb);
    sumbg = sum(bgbdb,2);
    sumug = sum(ugbdb,2);
    % cal new bass
    [~,bass] = max(sumbg);
    
    
    cb = bassgram(j);
    cr = rootgram(j);
    ct = treblegram(j);
    nb = bass;
    
    nb = cb;
    
    % score should be computed in terms of bass
    smaj = wmaj*sumug(pitchTranspose(nb,tmaj));
    smin = wmin*sumug(pitchTranspose(nb,tmin));
    smaj7 = wmaj7*sumug(pitchTranspose(nb,tmaj7));
    smin7 = wmin7*sumug(pitchTranspose(nb,tmin7));
    s7 = w7*sumug(pitchTranspose(nb,t7));
    smajon3 = wmajon3*sumug(pitchTranspose(nb,tmajon3));
    smajon5 = wmajon5*sumug(pitchTranspose(nb,tmajon5));
    sminonb3 = wminonb3*sumug(pitchTranspose(nb,tminonb3));
    sminon5 = wminon5*sumug(pitchTranspose(nb,tminon5));
    smaj7on3 = wmaj7on3*sumug(pitchTranspose(nb,tmaj7on3));
    smaj7on5 = wmaj7on5*sumug(pitchTranspose(nb,tmaj7on5));
    smaj7on7 = wmaj7on7*sumug(pitchTranspose(nb,tmaj7on7));
    smin7onb3 = wmin7onb3*sumug(pitchTranspose(nb,tmin7onb3));
    smin7on5 = wmin7on5*sumug(pitchTranspose(nb,tmin7on5));
    smin7onb7 = wmin7onb7*sumug(pitchTranspose(nb,tmin7onb7));
    s7on3 = w7on3*sumug(pitchTranspose(nb,t7on3));
    s7on5 = w7on5*sumug(pitchTranspose(nb,t7on5));
    s7onb7 = w7onb7*sumug(pitchTranspose(nb,t7onb7));
    
    sarr = [smaj, smin, smaj7, smin7, s7, smajon3, smajon5, sminonb3, sminon5, smaj7on3, smaj7on5, smaj7on7, smin7onb3, smin7on5, smin7onb7,...
        s7on3, s7on5, s7onb7];
    
    [~,I] = max(sarr);
    bassgram(j) = nb;
    rootgram(j) = bass2root(nb, narr{I});
    treblegram(j) = tname2tnum(narr{I}, chordmode); 
    
end