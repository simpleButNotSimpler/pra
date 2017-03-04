g = fspecial('gaussian', [1, 3], 8);
img1 = imfilter(imb, g);
img2 = imgaussfilt(imb,[1, 0.5]);

% imshow(img);
% imshowpair(img1, img2, 'montage');