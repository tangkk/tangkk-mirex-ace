% the chord mode is built this way with full chord notes
% the order matters when there is a tie matching score
%
% --chord--            --digit--     --dif--     --weight--    --type,#--
% 1->b2 b2             1,2              1            1          3
% 1->2 2               1,3              2            1          3
% 1->b3 min            1,4              3            1          2
% 1->3 maj             1,5              4            1          1
% 1->4 4               1,6              5            1          3
% 1->4# 4#             1,7              6            1          3
% 1->5 5               1,8              7            1          3
% 1->b6 b6             1,9              8            1          3
% 1->6 6               1,10             9            1          3
% 1->b7 b7             1,11             10           1          3
% 1->7 7+              1,12             11           1          3

% *********************** Active Region *******************************%
% 1->3->5 maj          1,5,8            4,7          1,1        1
% 1->b3->5 min         1,4,8            3,7          1,1        2
% 1->3->6 maj6         1,5,10           4,9          1,1        1
% 1->b3->6 min6        1,4,10           3,9          1,1        2
% 1->4->5 sus4         1,6,8            5,7          1,1        3
% 1->2->5 sus2         1,3,8            2,7          1,1        3
% 1->b3->b6 maj/3      1,4,9            3,8          1,1        2
% 1->4->6 maj/5        1,6,10           5,9          1,1        3
% 1->3->6 min/b3       1,5,10           4,9          1,1        1
% 1->4->b6 min/5       1,6,9            5,8          1,1        3
% 1->3->5# aug         1,5,9            4,8          1,1        1
% 1->b3->b5 dim        1,4,7            3,6          1,1        2
% 1->3->5->7 maj7      1,5,8,12         4,7,11       1,1-s,s    1
% 1->b3->5->b7 min7    1,4,8,11         3,7,10       1,1-s,s    2
% 1->b3->5->7 minmaj7  1,4,8,12         3,7,11       1,1-s,s    2
% 1->3->5->b7 7        1,5,8,11         4,7,10       1,1-s,s    1
% 1->b3->b5->bb7 dim7  1,4,7,10         3,6,9        1,1-s,s    2
% 1->b3->b5->b7 hdim   1,4,7,11         3,6,10       1,1-s,s    2
% 1->b3->5->b6 maj7/3  1,4,8,9          3,7,8        1,1-c,1-c  2
% 1->3->4->6 maj7/5    1,5,6,10         4,5,9        1,1-c,1-c  1
% 1->b2->4->b6 maj7/7  1,2,6,9          1,5,8        1,1-c,1-c  3
% 1->3->5->6 min7/b3   1,5,8,10         4,7,9        1,1-c,1-c  1
% 1->b3->4->b6 min7/5  1,4,6,9          3,5,8        1,1-c,1-c  2
% 1->2->4->6 min7/b7   1,3,6,10         2,5,9        1,1-c,1-c  3
% 1->b3->b5->b6 7/3    1,4,7,9          3,6,8        1,1-c,1-c  2
% 1->b3->4->6 7/5      1,4,6,10         3,5,9        1,1-c,1-c  2
% 1->2->b5->6 7/b7     1,3,7,10         2,6,9        1,1-c,1-c  3
% *********************************************************************%

% 1->2->4#->6 maj/b7   1,3,7,10         2,6,9        1,1-c,1-c  3
% 1->b2->4->b6 maj/7   1,2,6,9          1,5,8        1,1-c,1-c  3
% 1->2->4->b7 maj/2    1,3,6,11         2,5,10       1,1-c,1-c  3
% 1->2->4->6 min/b7    1,3,6,10         2,5,9        1,1-c,1-c  3
% 1->b2->3->b6 min/7   1,2,5,9          1,4,8        1,1-c,1-c  3
% 1->b2->4->b7 min/2   1,2,6,11         1,5,10       1,1-c,1-c  3


% if this file is modified, also check file "trebleTypeMapping.m",
% "trebleMatching.m", "trebleTransval.m" and "parseBassTreble.m"

% for naming conventions and labeling methodology, please refer to:
% Harte, C., M. Sandler, S. Abdallah, and E. Gómez. 2005.
% “Symbolic representation of musical chords: A proposed syntax for text
% annotations.” In Proceedings of the 6th International Society for Music
% Information Retrieval Conference (ISMIR), 66–71.

function chordmode = buildChordMode

s = 0.5; % seventh reduce factor
c = 0.5; % slash chord reduce factor
nchordtype = 50; % just leave aboundant space for chord types
chordmode = cell(4,nchordtype); %[dif; type; weight]

idx = 1;

% chordmode{1,idx} = 1;
% chordmode{2,idx} = 'b2';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 2;
% chordmode{2,idx} = '2';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 3;
% chordmode{2,idx} = 'm';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 4;
% chordmode{2,idx} = '';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 5;
% chordmode{2,idx} = '4';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 6;
% chordmode{2,idx} = '4#';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 7;
% chordmode{2,idx} = '5';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 8;
% chordmode{2,idx} = 'b6';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 9;
% chordmode{2,idx} = '6';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 10;
% chordmode{2,idx} = 'b7';
% chordmode{3,idx} = 1;
% idx = idx + 1;
% 
% chordmode{1,idx} = 11;
% chordmode{2,idx} = '7+';
% chordmode{3,idx} = 1;
% idx = idx + 1;

chordmode{1,idx} = [4,7];
chordmode{2,idx} = 'maj';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [3,7];
chordmode{2,idx} = 'min';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [4,9];
chordmode{2,idx} = 'maj6';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [3,9];
chordmode{2,idx} = 'min6';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [5,7];
chordmode{2,idx} = 'sus4';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [2,7];
chordmode{2,idx} = 'sus2';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [3,8];
chordmode{2,idx} = 'maj/3';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [5,9];
chordmode{2,idx} = 'maj/5';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [4,9];
chordmode{2,idx} = 'min/b3';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [5,8];
chordmode{2,idx} = 'min/5';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [4,8];
chordmode{2,idx} = 'aug';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [3,6];
chordmode{2,idx} = 'dim';
chordmode{3,idx} = [1,1];
idx = idx + 1;

chordmode{1,idx} = [4,7,11];
chordmode{2,idx} = 'maj7';
chordmode{3,idx} = [1,1-s,s];
idx = idx + 1;

chordmode{1,idx} = [3,7,10];
chordmode{2,idx} = 'min7';
chordmode{3,idx} = [1,1-s,s];
idx = idx + 1;

chordmode{1,idx} = [3,7,11];
chordmode{2,idx} = 'minmaj7';
chordmode{3,idx} = [1,1-s,s];
idx = idx + 1;

chordmode{1,idx} = [4,7,10];
chordmode{2,idx} = '7';
chordmode{3,idx} = [1,1-s,s];
idx = idx + 1;

chordmode{1,idx} = [3,6,9];
chordmode{2,idx} = 'dim7';
chordmode{3,idx} = [1,1-s,s];
idx = idx + 1;

chordmode{1,idx} = [3,6,10];
chordmode{2,idx} = 'hdim';
chordmode{3,idx} = [1,1-s,s];
idx = idx + 1;

chordmode{1,idx} = [3,7,8];
chordmode{2,idx} = 'maj7/3';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

chordmode{1,idx} = [4,5,9];
chordmode{2,idx} = 'maj7/5';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

chordmode{1,idx} = [1,5,8];
chordmode{2,idx} = 'maj7/7';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

chordmode{1,idx} = [4,7,9];
chordmode{2,idx} = 'min7/b3';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

chordmode{1,idx} = [3,5,8];
chordmode{2,idx} = 'min7/5';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

chordmode{1,idx} = [2,5,9];
chordmode{2,idx} = 'min7/b7';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

chordmode{1,idx} = [3,6,8];
chordmode{2,idx} = '7/3';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

chordmode{1,idx} = [3,5,9];
chordmode{2,idx} = '7/5';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

chordmode{1,idx} = [2,6,9];
chordmode{2,idx} = '7/b7';
chordmode{3,idx} = [1,1-c,1-c];
idx = idx + 1;

% chordmode{1,idx} = [2,6,9];
% chordmode{2,idx} = 'maj/b7';
% chordmode{3,idx} = [1,1-c,1-c];
% idx = idx + 1;
% 
% chordmode{1,idx} = [1,5,8];
% chordmode{2,idx} = 'maj/7';
% chordmode{3,idx} = [1,1-c,1-c];
% idx = idx + 1;
% 
% chordmode{1,idx} = [2,5,10];
% chordmode{2,idx} = 'maj/2';
% chordmode{3,idx} = [1,1-c,1-c];
% idx = idx + 1;
% 
% chordmode{1,idx} = [2,5,9];
% chordmode{2,idx} = 'min/b7';
% chordmode{3,idx} = [1,1-c,1-c];
% idx = idx + 1;
% 
% chordmode{1,idx} = [1,4,8];
% chordmode{2,idx} = 'min/7';
% chordmode{3,idx} = [1,1-c,1-c];
% idx = idx + 1;
% 
% chordmode{1,idx} = [1,5,10];
% chordmode{2,idx} = 'min/2';
% chordmode{3,idx} = [1,1-c,1-c];
% idx = idx + 1;

chordmode = chordmode(:,1:idx - 1);

for i = 1:1:size(chordmode,2)
    chordmode{4,i} = [trebleTypeMapping(chordmode{2,i}),length(chordmode{3,i})];
end
