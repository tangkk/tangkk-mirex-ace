% merge similar chords
% 1st pass: merge consecutive chords that share the same bass and same super type
% 2nd pass: merge consecutive chords if it follows 1->5 relationship
% 3rd pass: merge consecutive chords that share the same root and same treble type
% FIXME: also take care of the uppergram when merging (propagate/share
% uppergrams to all mergees)
% FIXME: do we need to care about supertype any more?
% FIXME: do we need to care about trebletype any more?
function [rootgram, bassgram, treblegram, uppergram, bdrys] =...
    mergeSimilarChords(rootgram, bassgram, treblegram, uppergram, bdrys, nfSeq, chordmode)

nslices = size(rootgram,2);

% 1st pass: merge consecutive chords that share the same bass and same super type
i = 1;
while i < nslices
    cb = bassgram(i);
    ct = treblegram(i);
    ctname = chordmode{2,ct};
    cst = superTypeMapping(ctname);
    
    nmergees = 0;
    for j = i + 1: 1: nslices
        nb = bassgram(j);
        nt = treblegram(j);
        ntname = chordmode{2,nt};
        nst = superTypeMapping(ntname);
        if cb == nb && (cst == nst || cst == 3 || nst == 3)
            nmergees = nmergees + 1;
        elseif nmergees > 0
            % propagate the uppergram and update other grams accordingly
            upper = normalizeGram(sum(uppergram(:,i:i+nmergees),2),2);
            bass = cb;
            [tname, treble] = trebleMatching(bass, upper, chordmode);
            root = bass2root(bass, tname);
            rootgram(i:i+nmergees) = ones(1,nmergees+1)*root;
            treblegram(i:i+nmergees) = castChords(nfSeq, bassgram(i:i+nmergees),...
                ones(1,nmergees+1)*treble, chordmode);
            break;
        else
            break;
        end
    end
    i = i + nmergees + 1;
end

% % 2nd pass: merge consecutive chords if it follows 1->5 relationship
% copybassgram = bassgram;
% for i = 1:1:nslices - 1
%     cb = bassgram(i);
%     ct = treblegram(i);
%     ctname = chordmode{2,ct};
%     cst = superTypeMapping(ctname);
%     cu = uppergram(:,i);
%     
%     cb5th = pitchTranspose(cb,7);
%     
%     nb = bassgram(i+1);
%     nt = treblegram(i+1);
%     ntname = chordmode{2,nt};
%     nst = superTypeMapping(ntname);
%     nu = uppergram(:,i+1);
%     
%     if cb5th == nb && cst ~= nst % deal with two positions at a time
%         % propagate the uppergram and update other grams accordingly
%         upper = normalizeGram(cu + nu,2);
%         bass = cb;
%         [tname, treble] = trebleMatching(bass, upper, chordmode);
%         root = bass2root(bass, tname);
%         rootgram(i:i+1) = [root root];
%         treblegram(i:i+1) = castChords(nfSeq, [cb cb], [treble treble], chordmode);
%         copybassgram(i:i+1) = [cb cb];
%     end
% end
% 
% bassgram = copybassgram;

% 3rd pass: merge consecutive chords that share the same root and same treble type
i = 1;
while i < nslices
    cb = bassgram(i);
    cr = rootgram(i);
    ct = treblegram(i);
    ctname = chordmode{2,ct};
    ctt = trebleTypeMapping(ctname);
    
    nmergees = 0;
    for j = i+1:1:nslices
        nb = bassgram(j);
        nr = rootgram(j);
        nt = treblegram(j);
        ntname = chordmode{2,nt};
        ntt = trebleTypeMapping(ntname);

        if cr == nr && ctt == ntt
            nmergees = nmergees + 1;
        elseif nmergees > 0
            % propagate the uppergram and update other grams accordingly
            upper = normalizeGram(sum(uppergram(:,i:i+nmergees),2),2);
            bass = mode(bassgram(i:i+nmergees));
            [tname, treble] = trebleMatching(bass, upper, chordmode);
            root = bass2root(bass, tname);
            bassgram(i:i+nmergees) = ones(1,nmergees+1)*bass;
            rootgram(i:i+nmergees) = ones(1,nmergees+1)*root;
            treblegram(i:i+nmergees) = castChords(nfSeq, bassgram(i:i+nmergees),...
                ones(1,nmergees+1)*treble, chordmode);
            break;
        else
            break;
        end
    end
    i = i + nmergees + 1;
end

[rootgram, bassgram, treblegram, bdrys] = combineSameChords(rootgram, bassgram, treblegram, bdrys);
