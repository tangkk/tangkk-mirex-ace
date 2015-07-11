function base = findBase(Sw, Swo)

ntones = size(Sw,1);
nslices = size(Sw,2);

basevec = zeros(1,ntones);
for j = 1:1:nslices
    for i = 1:1:ntones
        if Swo(i,j) > 0 && j < nslices/4 % onset salience with priority
            basevec(i) = basevec(i) + 1;
            break;
        end
    end
end
for j = 1:1:nslices
    for i = 1:1:ntones
        if Sw(i,j) > 0
            basevec(i) = basevec(i) + Sw(i,j); % onset salience with priority
            break;
        end
    end
end
basevec = basevec ./ max(basevec);
basevec(basevec <= 0.5) = 0;
base = 0;
for i = 1:1:ntones
    if basevec(i) > 0
        base = i;
        break;
    end
end