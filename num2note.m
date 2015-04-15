% 1 2  3 4  5 6 7  8 9  10 11 12 13
% C C# D D# E F F# G G# A  A# B  N
function note = num2note(num)

switch num
    case 0
        note = 'N';
    case 1
        note = 'C';
    case 2
        note = 'C#';
    case 3
        note = 'D';
    case 4
        note = 'D#';
    case 5
        note = 'E';
    case 6
        note = 'F';
    case 7
        note = 'F#';
    case 8
        note = 'G';
    case 9
        note = 'G#';
    case 10
        note = 'A';
    case 11
        note = 'A#';
    case 12
        note = 'B';
end