% 
% %     im1 = imread('pics/01.bmp');
% %     im1 = imread('pics/02.bmp');
% %     im1 = imread('pics/03.bmp');
% %     im1 = imread('pics/04.bmp');
% %     im1 = imread('pics/05.bmp');
% %     im1 = imread('pics/06.bmp');
% %     im1 = imread('pics/07.bmp');
% %     im1 = imread('pics/08.bmp');
% 
%     %color palmprint
% %     im1 = imread('IMG_001 (1).JPG');
% %     im1 = imread('IMG_001 (2).JPG');
% %     im1 = imread('IMG_002 (2).JPG');
% %     im1 = imread('IMG_002 (3).JPG');
% %     im1 = imread('IMG_003 (3).JPG');
% %     im1 = imread('IMG_003 (4).JPG');
%     im1 = imread('IMG_004 (4).JPG');
% %     im1 = imread('IMG_004 (5).JPG');
% %     im1 = imread('IMG_005 (5).JPG');
% %     im1 = imread('IMG_005 (6).JPG');
% 
%     %extract the layers
%     imr = im1(:, :, 1);
%     img = im1(:, :, 2);
%     imb = im2double(im1(:, :, 3));
%     imgray = rgb2gray(im1);
%     
% %apply sobel on x and y direction
% imgray = imgaussfilt(imgray);
[imx, imy] = imgradientxy(image);
[immag, imdir] = imgradient(imx, imy);
immag = immag / max(immag(:));

%plot the images
imshow(imx);

%gradient image to binary
imbin = im2bw(image, 0.5);

%multiply the gradients and the dirs
immul = imbin.*imdir;

%la and lb images
[m, n] = size(immul);
la_im = zeros(m, n); 
lb_im = zeros(m, n);

% idx = find(immul ~= 0 & ((imdir > 0 & imdir <= 90) | (imdir > -180 & imdir <= -90)));
idx = find(immul ~= 0 & (imdir > 0 & imdir <= 90));
la_im(idx) = 1;

% idx = find(immul ~= 0 & ((imdir >= 90 & imdir < 180) | (imdir > -90 & imdir < 0)));
idx = find(immul ~= 0 & (imdir >= 90 & imdir < 180));
lb_im(idx) = 1;

%get the radon transform of the images
theta = 0:90;
rlaim = radon(la_im, theta);
theta = 90:180;
rlbim = radon(lb_im, theta);

%get the im containing the greater total energy
sumla = sum(sum(rlaim));
sumlb = sum(sum(rlbim));
imagef = [];
if sumla >= sumlb
   imagef = la_im;
else
    imagef = lb_im;
end

%dilatation to fill small holes

%thining by eroding

%applying threshold to clean the image









