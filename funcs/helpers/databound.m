function bound = databound(t,tbdrys,boundtype)

if t <= tbdrys(1)
    bound = 1;
    return;
end

if t >= tbdrys(end)
    bound = length(tbdrys);
    return;
end

if strcmp(boundtype, 'st')
    st = t;
    for i = 1:1:length(tbdrys) - 1
        sb = tbdrys(i);
        eb = tbdrys(i+1);
        if st > sb && st <= eb
            bound = i+1;
            return;
        end
    end
end

if strcmp(boundtype, 'et')
    et = t;
    for i = 1:1:length(tbdrys) - 1
        sb = tbdrys(i);
        eb = tbdrys(i+1);
        if et >= sb && et < eb
            bound = i;
            return;
        end
    end
end


    