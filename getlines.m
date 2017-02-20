function p = getlines(im)
    [row, column] = find(im == 1);
    n = size(row, 1);
    p = zeros(n, 2);
    
    for idx=1:n
        p(idx, :) = 1;
    end
end