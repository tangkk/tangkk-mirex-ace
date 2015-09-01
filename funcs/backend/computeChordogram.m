% a chordogram in this context is a nchord*nslices dimension matrix
% indicating the strength of every chord candidates given the current chromagram
% note that the specicial treatment of the bass
% especially the non-chord bass
% applying this chordogram let us deal with the weight of different
% notes directly
function chordogram = computeChordogram(basegram, uppergram, chordmode, dbnparam)

nct = size(chordmode,2); % number of chord types defined in ``chordmode''
nchords = nct * 12 + 1; % + 1 is the no-chord
nslices = size(basegram,2);

chordogram = zeros(nchords,nslices);

% for the weights:
% Treble:
% chord note = 1, non-chord note = 0
% Bass:
% chord bass = 1, non-chord bass = 0.5, non-chord note = 0

for j = 1:nslices
    cgram = zeros(nchords,1);
    uj = uppergram(:,j);
    bj = basegram(:,j);
    
    % compute the scores of every possible chord candidates
    for b = 1:12 % stands for bass
        for ct = 1:nct % stands for chord type
            pc = pitchTranspose(b, [0 chordmode{1,ct}]);
            wc = chordmode{3,ct};
            tscore = uj(pc)'*[dbnparam.wTreble.*wc(1) ; dbnparam.wTreble.*wc'.*ones(length(pc)-1,1)];
            bscore = bj(pc)'*[dbnparam.wCBass.*wc(1) ; dbnparam.wNCBass.*wc'.*ones(length(pc)-1,1)];
            
            ichord = (b - 1) * nct + ct;
            cgram(ichord) = tscore + bscore;
        end
    end
     
    % FIXME: is this the correct way to deal with no-chord?
    cgram(end) = sum(uj)/2;
    
    chordogram(:,j) = cgram;
end
