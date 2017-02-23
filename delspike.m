function image = delspike(im, x, y, width)
    xend = x + width;
    yend = y + width;
    
    idx = find([im(x:xend, [y, yend]), im([x, xend], y:yend)'] == 1);
    
    bool = size(idx, 1);
    if bool == 0
       im(x:xend, y:yend) = 0;
    end
    
    image = im;
end
    