% recompute bass-treble using the confusion matrix information -
% revconf-J-10

function [rootgram, bassgram, treblegram] = bassTrebleCorrect5(rootgram,...
    bassgram, treblegram, basegram, uppergram, bdrys, chordmode)

wTreble = 1;
wCBass = 1;
wNCBass = 0.5;

nslices = size(rootgram,2);
load('revconf-J-10.mat');
chordnames = revconf(:,1);
chordnums = chnames2chnums(chordnames, chordmode);

for j = 1:nslices
    bd1 = bdrys(j);
    bd2 = bdrys(j+1);
    hsrbdb = bd1:bd2;
    bgbdb = basegram(:,hsrbdb);
    ugbdb = uppergram(:,hsrbdb);
    bj = median(bgbdb,2);
    uj = median(ugbdb,2);
    
    cb = bassgram(j);
    cr = rootgram(j);
    ct = treblegram(j);
    
    chscorearr = zeros(1,1);
    
    if cb ~= 0 % skip the N chords
        pc = pitchTranspose(cb, [0 chordmode{1,ct}]);
        wc = chordmode{3,ct};
        tscore = uj(pc)'*[wTreble.*wc(1) ; wTreble.*wc'.*ones(length(pc)-1,1)];
        bscore = bj(pc)'*[wCBass.*wc(1) ; wNCBass.*wc'.*ones(length(pc)-1,1)];
        chscorearr(1) = tscore + bscore;

        chnums = strcat(num2str(cr),':',num2str(ct));
        [ism,loc] = ismember(chnums,chordnums);
        sidx = 2;
        if ism
            confs = revconf(loc,2:end);
            for k = 1:length(confs)
                ch = confs{k};
                if ~isempty(ch)
                    % FIXME: should include N chord in the future
                    if ~isempty(strfind(ch,'X')) || strcmp(ch,'N') % skip 'N' and X:(X) chords
                        chscorearr(sidx) = 0;
                        sidx = sidx + 1;
                        continue;
                    end
                    strtoks = strsplit(ch,':');
                    root = strtoks{1};
                    treble = strtoks{2};
                    nr = note2num(root);
                    nt = tname2tnum(treble, chordmode);
                    nb = root2bass(nr, treble);
                    pc = pitchTranspose(nb, [0 chordmode{1,nt}]);
                    wc = chordmode{3,nt};
                    tscore = uj(pc)'*[wTreble.*wc(1) ; wTreble.*wc'.*ones(length(pc)-1,1)];
                    bscore = bj(pc)'*[wCBass.*wc(1) ; wNCBass.*wc'.*ones(length(pc)-1,1)];
                    chscorearr(sidx) = tscore + bscore;
                    sidx = sidx + 1;
                end
            end

            [~,I] = max(chscorearr);
            ch = revconf{loc,I};
            strtoks = strsplit(ch,':');
            root = strtoks{1};
            treble = strtoks{2};
            fr = note2num(root);
            ft = tname2tnum(treble, chordmode);
            fb = root2bass(fr, treble);
            rootgram(j) = fr;
            treblegram(j) = ft;
            bassgram(j) = fb;
        end
    end
end