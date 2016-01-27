% work with TheanoNN
function [rootgram, bassgram, treblegram] = loadingDecode(chordmode, beparam, rawbasegram, rawuppergram, bdrys, model)

if beparam.enBassTrebleCorrect
if beparam.enTheanoNN % if using TheanoNN, use raw basegram and uppergram
display('work with theano NN model...');
[rootgram, bassgram, treblegram] = theanoNN6SegPredict(rawbasegram, rawuppergram, bdrys, chordmode, model);
end
end

display('chord progression done...');
