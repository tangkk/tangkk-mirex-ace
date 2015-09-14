function g = logisticGradient(z)
    g = logistic(z).*(1 - logistic(z));
end
