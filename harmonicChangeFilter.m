function [Sh, Shv, Shc, nchords] = harmonicChangeFilter(Sg, Sb, So, ht, bc)

sizeS = size(Sg);
Sh = zeros(sizeS(1),sizeS(2)); % harmonic bounded salience matrix (one slice per col)
Shv = zeros(sizeS(1),sizeS(2)); % harmonic change matrix (one chord per col)
Shc = zeros(1,sizeS(2)); % harmonic change moments
whs = 0;
whe = 0;
shidx = 1;
firsttime = 1;
oldonset = 1;
newonset = 1;
for j = 1:1:sizeS(2)
    for i = 1:1:min(Sb(j) + bc,sizeS(1)) % search upper bounded by Sb + bc
        if (So(i,j) > ht && (j - whs > 0 || firsttime == 1)) || j == sizeS(2)
            newonset = i;
            if newonset == oldonset && j < sizeS(2)
                break;
            end
            if firsttime == 1
                firsttime = 0;
                whs = j;
                oldonset = newonset;
                break;
            end
            % take the mean over the harmonic window in terms of row
            if j == sizeS(2)
                whe = j;
                wh = whs:whe;
            else
                whe = j-1;
                wh = whs:whe;
            end
            for ii = max(oldonset - bc,1):1:sizeS(1) % count from oldonset - bc (elsewise bass inference)
                Sw = Sg(ii,wh);
                Sw(Sw>0) = 1;
                if sum(Sw) > 0.25*length(wh) % if the num of of light bin larger than 1/4 of wh
                    gesiiwh = mean(Sg(ii,wh));
                    Sh(ii,wh) = ones(1,length(wh))*gesiiwh;
                end
            end
            % make sure the oldonset place has at least something
            Sh(oldonset,wh) = min(Sh(oldonset,wh) + 0.5, 1);
            % normalize the content within harmonic window in terms of col
            for jj = whs:1:whe
                tmp = Sh(:,jj);
                if max(tmp) ~= 0
                    tmp = tmp / max(tmp);
                end
                tmp(tmp < 0.1) = 0;
                Sh(:,jj) = tmp;
            end
            
            % fill the harmonic change vector
            Shv(:,shidx) = Sh(:,whs);
            Shc(shidx) = whs;
            shidx = shidx + 1;
            whs = j;
            oldonset = newonset;
            break;
        end
    end
end
nchords = shidx - 1;
Shc(shidx) = sizeS(2);
Shv = Shv(:,(1:nchords));
Shc = Shc(:,(1:nchords+1)); % boundaries include the endtime
