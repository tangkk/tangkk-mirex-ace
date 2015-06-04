function [alignment] = getalignment2(dfframe,phwv,period,timesig)


period = round(period);



%normalise and linearly weight most recent strongest
%dfframe = dfframe.*([1:length(dfframe)]);

% reverse 
dfframe = dfframe(end:-1:1); 

% output of alignment comb filter
phcf = zeros(1,period);

numelem = floor((length(dfframe)-0)/period);

%dfframe = [dfframe' zeros(1,length(dfframe))]';
%this line is neeeded for using commented part below

if (~timesig) % initial state

   

    % fit as many as possible
    for i=1:period
        for b = 1:numelem, 
                phcf(i) = phcf(i) + dfframe(( b-1)*period+i) * phwv(i); %+ ...
%  			dfframe(( b-1)*period+i+1) * phwv(i) + ...
%    				dfframe(( b-1)*period+i+2) * phwv(i);% + ...
%    				dfframe(( b-1)*period+i+3) * phwv(i) + ...
%  				dfframe(( b-1)*period+i+4) * phwv(i);
         end
    end

else

    numelem = timesig; 
    for i=1:period
        for b = 1:numelem, 
         %   for a = 1-b:b-1
            phcf(i) = phcf(i) + dfframe(( b-1)*period+i) * phwv(i) + ...
			dfframe(( b-1)*period+i+1) * phwv(i) + ...
				dfframe(( b-1)*period+i+2) * phwv(i) + ...
				dfframe(( b-1)*period+i+3) * phwv(i) + ...
				dfframe(( b-1)*period+i+4) * phwv(i);
          %  end
        end
    end

end


[val,alignment] = max(phcf);
[val2,bestguess] = max(phwv);

if alignment>=2,
alignment = alignment-1;
end