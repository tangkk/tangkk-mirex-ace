function [period,rcf,period2] = getperiod(acf,wv,timesig,pmax,pmin,lowest)


% using for loop approach to extract beat period

pmax = round(pmax);
pmin = round(pmin);

rcf = zeros(1,pmax);


if(~timesig) % timesig unknown, must be general state
    numelem = 4;

    for i=pmin:pmax-1, % maximum beat period
        for a=1:numelem, % number of comb elements
            for b=1-a:a-1, % gs using normalization of comb elements
                rcf(i) = rcf(i) + (acf(a*i+b)*wv(i))/(2*a-1);
            end
        end
    end

else
    numelem = timesig; % timesig known must be context dependent state

    for i=pmin:pmax-1, % maximum beat period
        for a=1:numelem, % number of comb elements
            for b=1-a:a-1, % cds not normalizing comb elements
                rcf(i) = rcf(i) + acf(a*i+b)*wv(i);
            end
        end
    end

end


[val, period] = max(rcf); 




period = refineperiod(period,acf,timesig);


 while(period<lowest)
     period = period*2;
 end
%period

if (~sum(abs(wv))) % i.e. using cds_wv before initialised
    period = 0;
end

% not important... just here to prevent an error in the number of outputs
period2 = period*2;
%figure(1); plot(rcf); pause