% this maps treble to a treble class
% more trebles are to be added
function tt = trebleTypeMapping(treble)
% FIXME: how to deal with no-chord 'N'
% FIXME: implement MIREX standard chord matching
% FIXME: whether the whole reason behind the super treble type is correct?

%     % type 1 cases:
%     case '0'
%         tt = 1; % 0 type of treble also 1
%     case ''
%         tt = 1;
%     case 'M'
%         tt = 1;
%     case 'maj'
%         tt = 1;
%     case 'maj6'
%         tt = 1;
%     case 'M6'
%         tt = 1;
%     case 'maj7'
%         tt = 1;
%     case 'M7'
%         tt = 1;
%     case 'maj9'
%         tt = 1;
%     case 'M9'
%         tt = 1;
%     case '7'
%         tt = 1;
%     case 'dom7'
%         tt = 1;
%     case 'aug'
%         tt = 1;
%     case '+'
%         tt = 1;
%     case '+7'
%         tt = 1;
%     case 'min/b3'
%         tt = 1;
%     case 'maj7/5'
%         tt = 1;
%     case 'min7/3'
%         tt = 1;
%         
%     % type 2 cases
%     case 'm'
%         tt = 2;
%     case 'min'
%         tt = 2;
%     case 'm6'
%         tt = 2;
%     case 'min6'
%         tt = 2;
%     case 'min7'
%         tt = 2;
%     case 'm7'
%         tt = 2;
%     case 'minmaj7'
%         tt = 2;
%     case 'mM7'
%         tt = 2;
%     case 'm7-5'
%         tt = 2;
%     case 'm7b5'
%         tt = 2;
%     case 'hdim'
%         tt = 2;
%     case '-'
%         tt = 2;
%     case 'dim'
%         tt = 2;
%     case 'dim7'
%         tt = 2;
%     case '-7'
%         tt = 2;
%     case '/3'
%         tt = 2;
%     case 'maj/3'
%         tt = 2;
%     case 'maj7/3'
%         tt = 2;
%     case 'min7/5'
%         tt = 2;
%     case '7/3'
%         tt = 2;
%     case '7/5'
%         tt = 2;
%         
%     % type 3 cases
%     case 'b2'
%         tt = 3;
%     case '2'
%         tt = 3;
%     case '4'
%         tt = 3;
%     case '4#'
%         tt = 3;
%     case '5'
%         tt = 3;
%     case 'b6'
%         tt = 3;
%     case '6'
%         tt = 3;
%     case 'b7'
%         tt = 3;
%     case '7+'
%         tt = 3;
%     case 'sus4'
%         tt = 3;
%     case 'sus2'
%         tt = 3;
%     case 'm/5'
%         tt = 3;
%     case 'm/b7'
%         tt = 3;
%     case 'm/7'
%         tt = 3;
%     case 'm/2'
%         tt = 3;
%     case '/5'
%         tt = 3;
%     case '/b7'
%         tt = 3;
%     case '/7'
%         tt = 3;
%     case '/2'
%         tt = 3;
%     case 'min/5'
%         tt = 3;
%     case 'min/b7'
%         tt = 3;
%     case 'min/7'
%         tt = 3;
%     case 'min/2'
%         tt = 3;
%     case 'maj/5'
%         tt = 3;
%     case 'maj/b7'
%         tt = 3;
%     case 'maj/7'
%         tt = 3;
%     case 'maj/2'
%         tt = 3;
%     case 'maj7/7'
%         tt = 3;
%     case 'min7/b7'
%         tt = 3;
%     case '7/b7'
%         tt = 3;

switch treble
    case 'maj'
        tt = 1;
    case 'maj6'
        tt = 1;
    case 'maj7'
        tt = 1;
    case 'maj9'
        tt = 1;
    case 'maj11';
        tt = 1;
    case '7'
        tt = 1;
    case '9'
        tt = 1;
    case '11'
        tt = 1;
    case 'add9'
        tt = 1;
    case 'add11'
        tt = 1;
        
    case 'min'
        tt = 2;
    case 'min6'
        tt = 2;
    case 'min7'
        tt = 2;
    case 'min9'
        tt = 2;
    case 'min11'
        tt = 2;
    case 'madd9'
        tt = 2;
    case 'madd11'
        tt = 2;
        
    otherwise
        tt = 0;
end