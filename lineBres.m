function lineBres(x1, y1, x2, y2, mat)
    dx = abs(x2 - x1);
    dy = abs(y2 - y1);
    p = 2*dy - dx;
    xend = 0;
    x = 0;
    y = 0;
    
    if x1 > x2
       x = x2;
       y = y2;
       xend = x1;
    else
       x = x1;
       y = y1;
       xend = x2; 
    end
    mat(x, y) = 1;
    
    while x < xend
        x = x + 1;
        if p < 0
            p = p + 2*dy;
        else
            y = y + 1;
            p = p + 2*dy - 2*dx;
        end
        mat(x, y);
    end
end