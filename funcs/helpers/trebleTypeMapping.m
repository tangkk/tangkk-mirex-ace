% map the treble to treble type according to whether they derive from
% major(type 1), minor(type 2) or neither(type 0)
function tt = trebleTypeMapping(treblename)

switch treblename
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
    case 'maj/3'
        tt = 1;
    case 'maj/5'
        tt = 1;
    case 'maj7/3'
        tt = 1;
    case 'maj7/5'
        tt = 1;
    case 'maj7/7'
        tt = 1;
    case '7/3'
        tt = 1;
    case '7/5'
        tt = 1;
    case '7/b7'
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
    case 'min/b3'
        tt = 2;
    case 'min/5'
        tt = 2;
    case 'min7/b3'
        tt = 2;
    case 'min7/5'
        tt = 2;
    case 'min7/b7'
        tt = 2;
        
    otherwise
        tt = 0;
end