close all;

im1 = imread('imtest.jpg');

imb = im2double(rgb2gray(im1));
imb = imcomplement(imb);

subplot(4, 4, 1), imshow(im1);
subplot(4, 4, 2), imshow(imb);

im = imb;
for t=1:12
    im = edgeresponse(im, 'max');
    subplot(4, 4, t+2), imshow(im);
    im = oldedgeresponse(im, 'max');
    subplot(4, 4, t+3), imshow(im);
end