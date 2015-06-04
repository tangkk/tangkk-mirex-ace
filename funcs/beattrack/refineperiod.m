function period = refineperiod(period,acf,timesig);


if ~timesig, timesig=4; end

% peaks = zeros(1,timesig);
% ind = period;
% for i=1:timesig
%     segment = acf(ind*i-(i-1):ind*i+(i-1));
%     [val,loc] = max(segment);
%     peaks(i) = loc + ind*i-(i-1)-1;
% end
% 
% 
% for i=1:timesig
%     peaks(i) = (peaks(i)-1)/i;
% end
% 
% period = mean(peaks);
% 
% 





% 
% 
if ~timesig
    timesig =4;
end

ind = period;

if (timesig==4)
    peak = zeros(1,4);

    peak(1) = ind;

    [val2,ind2] = max(acf(2*ind-1:2*ind+1));
    peak(2) = ind2 + 2*ind-2;

    [val3,ind3] = max(acf(3*ind-2:3*ind+2));
    peak(3) = ind3 + 3*ind-4;

    [val4,ind4] = max(acf(4*ind-3:4*ind+3));
    peak(4) = ind4 + 4*ind-9;

    period = mean([ peak(1) peak(2)/2 peak(3)/3 peak(4)/4 ]);

else

    peak = zeros(1,3);

    peak(1) = ind;

    [val2,ind2] = max(acf(2*ind-1:2*ind+1));
    peak(2) = ind2 +2*ind-2;

    [val3,ind3] = max(acf(3*ind-2:3*ind+2));
    peak(3) = ind3 + 3*ind-4;

    period = mean([ peak(1) peak(2)/2 peak(3)/3 ]);

end
