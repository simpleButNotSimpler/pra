function idx = closestpoints(fixed, moving)
    len = size(fixed, 1);
    idx = zeros(len, 2);
    for t=1:len
        fixp = fixed(t, :);
        mindist = 56478;
        for k=1:len
            dist = fixp - moving(k, :);
            dist = sqrt(sum(dist.^2));
            if dist < mindist && dist~= 0
                mindist = dist;
                idx(t, 1) = k;
                idx(t, 2) = mindist;
            end
        end
    end
    temp = 1:len;
    idx(:, 3) = temp';
end