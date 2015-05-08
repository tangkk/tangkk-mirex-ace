function visualizeChordProgression(outchordogram, outbassgram, outboundaries, tt)

if nargin == 3
    scrsz = get(groot,'ScreenSize');
    figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    hold on;
    Y = -10:0.1:10;
    for i = 1:1:length(outboundaries)
        X = outboundaries(1,i)*ones(size(Y));
        plot(X,Y);
    end
    hold off;
    div = (max(Y) - min(Y) - 1) / length(outchordogram);
    for i = 1:1:length(outchordogram)
        x = outboundaries(i);
        if isempty(strfind(outchordogram{i}, '/'))
            chordstr = outchordogram{i};
            text(x,10 - i*div,chordstr);
        else
            originchordstr = strsplit(outchordogram{i},'/');
            treble = originchordstr{1};
            bassstr = num2note(outbassgram(i));
            chordstr = strcat(treble, '/', bassstr);
            text(x,10 - i*div,chordstr);
        end
    end
    xlabel('slice');
    ylabel('chord');
    title('updated chordprogression vs. slice');
end

if nargin == 4
    scrsz = get(groot,'ScreenSize');
    figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    hold on;
    Y = -10:0.1:10;
    for i = 1:1:length(outboundaries)
        X = tt(outboundaries(1,i))*ones(size(Y));
        plot(X,Y);
    end
    hold off;
    div = (max(Y) - min(Y) - 1) / length(outchordogram);
    for i = 1:1:length(outchordogram)
        x = tt(outboundaries(i));
        if isempty(strfind(outchordogram{i}, '/'))
            chordstr = outchordogram{i};
            text(x,10 - i*div,chordstr);
        else
            originchordstr = strsplit(outchordogram{i},'/');
            treble = originchordstr{1};
            bassstr = num2note(outbassgram(i));
            chordstr = strcat(treble, '/', bassstr);
            text(x,10 - i*div,chordstr);
        end
    end
    xlabel('time');
    ylabel('chord');
    title('updated chordprogression vs. time');
end