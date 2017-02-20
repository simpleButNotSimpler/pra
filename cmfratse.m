function mat = cmfratse(row, col, angle)
    if row > col
       col = row;
    else
        row = col;
    end
    
    row = row + 2;
    col = col + 2;
    mat = zeros(row, col);
    
    m = -tand(angle);
    a = round(col / 2);
    b = round(row / 2);
    
    if (angle >= 0 && angle <= 45) || (angle > 135 && angle <= 180)
        for x=col-1:-1:2
            y = round(m*(x - a) + b);
            mat([y-1, y, y+1], x) = 1;
        end
        
    elseif angle > 45 && angle <= 135
        for y=row-1:-1:2
            x = round((y - b)/m + a);
            mat(y, [x-1, x, x+1]) = 1;
        end
    end
end