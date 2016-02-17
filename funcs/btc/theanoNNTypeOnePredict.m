% estimate the sequence using theano based parametric and non-parametric
% 6seg models
 
function [rootgram, bassgram, treblegram] = theanoNNTypeOnePredict(basegram, uppergram, chordmode, dbn2param, model)

win = 6; % assuming 6seg, every seg has 2 slices
if ~isempty(strfind(model,'-inv-'))
    nchords = 277;
elseif ~isempty(strfind(model,'-noinv-'))
    nchords = 61;
end
bnet4 = dbnSetup4(dbn2param, nchords);
chordogram = computeNNChordogram(basegram, uppergram, chordmode, model, win);
[chordogram, ~] = normalizeGram(chordogram, inf);
[rootgram, bassgram, treblegram] = dbnInference4(bnet4, chordmode, chordogram, nchords);