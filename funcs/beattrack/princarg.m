function phase=princarg(phasein)
%phase=princarg(phasein) maps phasein into the [-pi:pi] range
    phase=mod(phasein+pi,-2*pi)+pi;
