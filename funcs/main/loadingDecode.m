% work with TheanoNN
function [rootgram, bassgram, treblegram] = loadingDecode(chordmode, beparam, rawbasegram, rawuppergram, bdrys)

if beparam.enBassTrebleCorrect
if beparam.enTheanoNN % if using TheanoNN, use raw basegram and uppergram
display('work with theano NN model...');
[rootgram, bassgram, treblegram] = feval(['bassTrebleCorrect',num2str(beparam.btcVersion)],...
    rawbasegram, rawuppergram, bdrys, chordmode);
end
end

display('chord progression done...');
