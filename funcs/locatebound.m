function bound = locatebound(t,boundaries,boundtype)

bound = zeros(1,2);
if strcmp(boundtype, 'st')
    st = t;
    for i = 1:1:length(boundaries) - 1
        sb = boundaries(i);
        eb = boundaries(i+1);
        if st >= sb && st < eb
            bound(1) = i;
            bound(2) = i+1;
            break;
        end
    end
end

if strcmp(boundtype, 'et')
    et = t;
    for i = 1:1:length(boundaries) - 1
        sb = boundaries(i);
        eb = boundaries(i+1);
        if et > sb && et <= eb
            bound(1) = i;
            bound(2) = i+1;
            break;
        end
    end
end

if strcmp(boundtype, 'wt')
    wt = t;
    for i = 1:1:length(boundaries) - 1
        sb = boundaries(i);
        eb = boundaries(i+1);
        if wt >= sb && wt <= eb
            bound(1) = i;
            bound(2) = i+1;
            break;
        end
    end
end


    