% correct the bassgram based on the first 1/8 of the harmonic regions of
% the basegram, and update rootgram and treblegram accordingly.
% The dominant bass of the 1/8 of
% the harmonic stable region will be the chord bass of the whole harmonic
% region

function [rootgram, bassgram, treblegram] = bassTrebleCorrect(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode, bassTrebleVersion)

switch bassTrebleVersion
    case 0
        [rootgram, bassgram, treblegram] = bassTrebleCorrect0(rootgram,...
            bassgram, treblegram, basegram, uppergram, bdrys, chordmode);
    case 1
        [rootgram, bassgram, treblegram] = bassTrebleCorrect1(rootgram,...
            bassgram, treblegram, basegram, uppergram, bdrys, chordmode);
    case 2
        [rootgram, bassgram, treblegram] = bassTrebleCorrect2(rootgram,...
            bassgram, treblegram, basegram, uppergram, bdrys, chordmode);
    
    case 3
        [rootgram, bassgram, treblegram] = bassTrebleCorrect3(rootgram,...
            bassgram, treblegram, basegram, uppergram, bdrys, chordmode);
        
    case 4
        [rootgram, bassgram, treblegram] = bassTrebleCorrect4(rootgram,...
            bassgram, treblegram, basegram, uppergram, bdrys, chordmode);
    
    case 5
        [rootgram, bassgram, treblegram] = bassTrebleCorrect5(rootgram,...
            bassgram, treblegram, basegram, uppergram, bdrys, chordmode);
end