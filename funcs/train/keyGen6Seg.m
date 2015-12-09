% transform 1 key note salience matrix data to 12 keys
% the transposition is performed with the data's original key as a pivot
% the transposition is performed from -5 to +6
% a semitone corresponds to 3 bins in salience matrx
function keyGen6Seg(in,outname)

data1key = load(in);
Xin = data1key.X;
yin = data1key.y;
m = size(Xin,1);
load chordnames.mat;
chordmode =  chordTypesGen;
chordnums = [chnames2chnums(chordnames, chordmode);'0:0'];

X = [];
y = [];
idx = 1;
for i = 1:m
    Xi = Xin(i,:);
    yi = yin(i);
    if yi ~= 0
        ynum = chordnums{yi};
    else
        ynum = '0:0';
    end
    
    % non transpose
    X(idx,:) = Xi;
    y(idx,:) = yi;
    idx = idx + 1;
    
    
    % neg transpose
    for j = 1:5
        TXi = [];
        for k = 1:6 % transpose for all 6 sections
            Xt = Xi((k-1)*252+1:(k)*252);
            padlen = j*3;
            pad = zeros(1,padlen);
            TXt = [Xt(1+padlen:end) pad];
            TXi = [TXi TXt];
        end
        X(idx,:) = TXi;
        nynum = chTranspose(ynum, -j);
        [~,nyi] = ismember(nynum,chordnums);
        y(idx,:) = nyi;
        idx = idx + 1;
    end
    
    % pos transpose
    for j = 1:6
        TXi = [];
        for k = 1:6
            Xt = Xi((k-1)*252+1:(k)*252);
            padlen = j*3;
            pad = zeros(1,padlen);
            TXt = [pad Xt(1:end-padlen)];
            TXi = [TXi TXt];
        end
        X(idx,:) = TXi;
        nynum = chTranspose(ynum, j);
        [~,nyi] = ismember(nynum,chordnums);
        y(idx) = nyi;
        idx = idx + 1;
    end
end

save(outname,'X','y');
