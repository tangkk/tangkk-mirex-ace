function transval = trebleTransval(treble)

tokens = strsplit(treble,'/'); % in case the input contains '/'
if length(tokens) > 1
    token = tokens{2};
else
    token = tokens{1};
end

switch token
    case 'b2'
        transval = 1;
    case '2'
        transval = 2;
    case 'b3'
        transval = 3;
    case '3'
        transval = 4;
    case '4'
        transval = 5;
    case 'b5'
        transval = 6;
    case '5'
        transval = 7;
    case 'b6'
        transval = 8;
    case '6'
        transval = 9;
    case 'b7'
        transval = 10;
    case '7'
        transval = 11;
    otherwise
        transval = 0;
end

%     case 'maj/3'
%         transval = 4;
%     case 'min/b3'
%         transval = 4;
%     case 'maj/5'
%         transval = 7;
%     case 'min/5'
%         transval = 7;
%     
%     case 'maj7/3'
%         transval = 4;
%     case 'maj7/5'
%         transval = 7;
%     case 'maj7/7'
%         transval = 11;
%         
%     case 'min7/b3'
%         transval = 3;
%     case 'min7/5'
%         transval = 7;
%     case 'min7/b7'
%         transval = 10;
%         
%     case '7/3'
%         transval = 4;
%     case '7/5'
%         transval = 7;
%     case '7/b7'
%         transval = 10;
%         
%     case 'maj/b7'
%         transval = 10;
%     case 'min/b7'
%         transval = 10;
%     case 'maj/7'
%         transval = 11;
%     case 'min/7'
%         transval = 11;
%     case 'maj/2'
%         transval = 2;
%     case 'min/2'
%         transval = 2;
