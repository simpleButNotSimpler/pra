function image = maxresponse(im0, im20, im40, im60, im80, im100, im120, im140, im160)
    [row, col] = size(im0);
    image = zeros(row, col);
    for t=1:row
       for k=1:col
            image(t, k) = max([im0(t, k), im20(t, k), im40(t, k), im60(t, k), im80(t, k), im100(t, k), im120(t, k), im140(t, k), im160(t, k)]);  
       end
    end
end