A = dir('./cd');

B = {A.name}; B = B(3:end);

for i = 1:length(B)
    C = ['./cd/',B{i}];
    D = dir(C);
    E = {D.name}; E = E(3:end);
    for j = 1:length(E)
        F = [C '/' E{j}];
        disp(F);
        transformCD(F);
    end
end