function gram = zero2one(gram)

% find out the index of columns where maximum is zero
maxin = max(gram);
i = find(maxin == 0);

temp = gram(:,i);
temp(:) = 1;
gram(:,i) = temp;