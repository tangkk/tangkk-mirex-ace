% Wrapped phase means that all phase points are constrained to the range
% -180 degrees ? Phase Offset < 180 degrees. When the actual phase is outside this range,
%the phase value is increased or decreased by a multiple of 360 degrees to put the phase value
%within +/- 180 degrees of the Phase Offset value.
function out = wrapd(in)

while (true)
    if in < -pi
        in = in + 2*pi;
    elseif in >= pi
        in = in - 2*pi;
    else
        break;
    end
end

out = in;