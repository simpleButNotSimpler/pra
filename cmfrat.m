function mat = cmfrat(row, col, angle)
    row = row + 4;
    col = col + 4;
    mat = zeros(row, col);
    
    m = -tand(angle);
    a = round(col / 2);
    b = round(row / 2);
    
    if (angle >= 0 && angle <= 45) || (angle > 135 && angle <= 180)
        for x=col - 2:-1:3
            y = round(m*(x - a) + b);
            mat([y-1, y, y+1], x) = -1/22;
            mat([y-3, y-2, y+2, y+3], x) = 1/11;
        end
        
    elseif angle > 45 && angle <= 135
        for y=row - 2:-1:3
            x = round((y - b)/m + a);
            mat(y, [x-1, x, x+1]) = -1/22;
            mat(y, [x-3, x-2, x+2, x+3]) = 1/11;
        end
    end
end