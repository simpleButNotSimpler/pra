function th = percentile(im, perc)
    [counts, xi] = imhist(im);
    percent = counts/sum(counts) * 100;
    th = 1;
    temp = 0;
    while temp < perc && th <= 255
       temp = temp + percent(th);
       th = th + 1;
    end
    
    th = xi(th);
end