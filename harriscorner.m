function points = harriscorner(im)
%    im = im2double(rgb2gray(im));
   im = im2double(im);
   
   %derivatives in x and y direction
   [dx, dy] = meshgrid(-1:1, -1:1); 
   imx = conv2(im, dx, 'same');
   imy = conv2(im, dy, 'same');
   
   sigma = 1.8;
   radius = 1;
   order = (2*radius + 1);
   threshold = 0;
   
   %gaussian filter
   gf = gaussfilter(sigma);
   
   %calculate m matrix
   ix2 = conv2(imx.^2, gf, 'same');
   iy2 = conv2(imy.^2, gf, 'same');
   ixy = conv2(imx.*imy, gf, 'same');
   
   %harris measure
   R = (ix2.*iy2 - ixy.^2) ./ (ix2 + iy2 +eps);
   
   %find local maxima
   mx = ordfilt2(R, order^2, ones(order));
   harris_points = (R == mx) & (R > threshold);
   
   [rows, cols] = find(harris_points);
   
   points = cornerPoints([cols, rows]);
   
   %plotting
%    figure, imshow(im), hold on;
%    plot(cols, rows, '+r'), title('harris corner');
end

function gf = gaussfilter(sigma)
    dim = max(1, fix(6*sigma));
    m = fix((dim-1)/2);
    n = fix((dim-1)/2);
    [h1, h2] = meshgrid(-m:m, -n:n);
    hg = exp(-(h1.^2 + h2.^2) / (2*sigma^2));
   
    gf = hg / sum(sum(hg));    
end