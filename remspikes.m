function image = remspikes(im, width)
    image = im;
    [m, n] = size(im);
    m = m - width;
    n = n - width;
    
    for t=1:m
        for k=1:n
            image = delspike(image, t, k, width);           
        end
    end
end