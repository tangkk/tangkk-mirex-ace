% perform stochastic binary logistic units' activities
function binary = sample_bernoulli(probabilities)
%     seed = sum(probabilities(:));
%     binary = +(probabilities > a4_rand(size(probabilities), seed)); % the "+" is to avoid the "logical" data type, which just confuses things.
    binary = +(probabilities > rand(size(probabilities)));
end

