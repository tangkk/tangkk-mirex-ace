% map the treble to its super type according to whether it contains
% a 1-3 interval(type 1), 1-b3 interval(type 2) or neither(type3)

function st = superTypeMapping(tname)
% FIXME: how to deal with no-chord 'N'
% FIXME: implement MIREX standard chord matching
% FIXME: whether the whole reason behind the super treble type is correct?

switch tname
    % type 1 cases:
    case '0'
        st = 1;
    case '1'
        st = 1;
    case ''
        st = 1;
    case 'M'
        st = 1;
    case 'maj'
        st = 1;
    case 'maj6'
        st = 1;
    case 'M6'
        st = 1;
    case 'maj7'
        st = 1;
    case 'M7'
        st = 1;
    case 'maj9'
        st = 1;
    case 'M9'
        st = 1;
    case '7'
        st = 1;
    case 'dom7'
        st = 1;
    case 'aug'
        st = 1;
    case '+'
        st = 1;
    case '+7'
        st = 1;
    case 'min/b3'
        st = 1;
    case 'maj7/5'
        st = 1;
    case 'min7/3'
        st = 1;
        
    % type 2 cases
    case 'm'
        st = 2;
    case 'min'
        st = 2;
    case 'm6'
        st = 2;
    case 'min6'
        st = 2;
    case 'min7'
        st = 2;
    case 'm7'
        st = 2;
    case 'minmaj7'
        st = 2;
    case 'mM7'
        st = 2;
    case 'm7-5'
        st = 2;
    case 'm7b5'
        st = 2;
    case 'hdim'
        st = 2;
    case '-'
        st = 2;
    case 'dim'
        st = 2;
    case 'dim7'
        st = 2;
    case '-7'
        st = 2;
    case '/3'
        st = 2;
    case 'maj/3'
        st = 2;
    case 'maj7/3'
        st = 2;
    case 'min7/5'
        st = 2;
    case '7/3'
        st = 2;
    case '7/5'
        st = 2;
        
    % type 3 cases
    case 'b2'
        st = 3;
    case '2'
        st = 3;
    case '4'
        st = 3;
    case '4#'
        st = 3;
    case '5'
        st = 3;
    case 'b6'
        st = 3;
    case '6'
        st = 3;
    case 'b7'
        st = 3;
    case '7+'
        st = 3;
    case 'sus4'
        st = 3;
    case 'sus2'
        st = 3;
    case 'm/5'
        st = 3;
    case 'm/b7'
        st = 3;
    case 'm/7'
        st = 3;
    case 'm/2'
        st = 3;
    case '/5'
        st = 3;
    case '/b7'
        st = 3;
    case '/7'
        st = 3;
    case '/2'
        st = 3;
    case 'min/5'
        st = 3;
    case 'min/b7'
        st = 3;
    case 'min/7'
        st = 3;
    case 'min/2'
        st = 3;
    case 'maj/5'
        st = 3;
    case 'maj/b7'
        st = 3;
    case 'maj/7'
        st = 3;
    case 'maj/2'
        st = 3;
    case 'maj7/7'
        st = 3;
    case 'min7/b7'
        st = 3;
    case '7/b7'
        st = 3;
end