function [timesig,three_energy,four_energy] = findmeter_mm(acf,period,thresh);

% a simple enegy test with current period value, where energy is evaluated
% at small regions at double and four times the period, to be compared with
% energy at 3 and 6 times the beat period, to decide if the time signature
% of the current frame is duple or triple.

if nargin<3
	thresh = 0;
%default state
end


acf = acf/sum(acf);

period = round(period);

sw= 2;


%  % new approach - LESS GOOD than the old approach
%  
%  numperiods = floor(length(acf)/period);
%  num4multiples = floor(numperiods/4);
%  %  % just check we haven't gone over the end of the acf
%  num4multiples = num4multiples- double((period*num4multiples*4+sw) > length(acf));
%  
%  % initialize;
%  three_energy = 0;
%  four_energy = 0;
%  
%  for i=1:length(num4multiples)
%  
%  	three_energy = three_energy + sum(acf(3*i*period-sw:1:3*i*period+sw));
%  	four_energy = four_energy + sum(acf(4*i*period-sw:1:4*i*period+sw));
%  
%  end


% old approach... 

if(length(acf)<6*period+sw)
    

    three_energy = sum(acf(3*period-sw:1:3*period+sw));

    four_energy = sum(acf(4*period-sw:1:4*period+sw));

else

    three_energy = sum(acf(3*period-sw:1:3*period+sw)) + sum(acf(6*period-sw:1:6*period+sw));

    four_energy = sum(acf(4*period-sw:1:4*period+sw)) + sum(acf(2*period-sw:1:2*period+sw));

end


if ( (four_energy - three_energy) >= thresh )
    timesig = 4;
else
    timesig = 3;
end
