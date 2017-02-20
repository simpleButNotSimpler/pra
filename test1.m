
%     im1 = imread('pics/01.bmp');
%     im1 = imread('pics/02.bmp');
%     im1 = imread('pics/03.bmp');
%     im1 = imread('pics/04.bmp');
%     im1 = imread('pics/05.bmp');
%     im1 = imread('pics/06.bmp');
%     im1 = imread('pics/07.bmp');
%     im1 = imread('pics/08.bmp');

    %color palmprint
%     im1 = imread('IMG_001 (1).JPG');
%     im1 = imread('IMG_001 (2).JPG');
%     im1 = imread('IMG_002 (2).JPG');
%     im1 = imread('IMG_002 (3).JPG');
%     im1 = imread('IMG_003 (3).JPG');
%     im1 = imread('IMG_003 (4).JPG');
    im1 = imread('IMG_004 (4).JPG');
%     im1 = imread('IMG_004 (5).JPG');
%     im1 = imread('IMG_005 (5).JPG');
%     im1 = imread('IMG_005 (6).JPG');

    %extract the blue layer
    imr = im1(:, :, 1);
    img = im1(:, :, 2);
    imb = im1(:, :, 3);
    imgray = rgb2gray(im1);
    
    %print the tree layers
%     figure;
%     subplot(1, 4, 1), imshow(imr), title('red layer');
%     subplot(1, 4, 2), imshow(img), title('green layer');
%     subplot(1, 4, 3), imshow(imb), title('blue layer');
%     subplot(1, 4, 4), imshow(imgray), title('gray image');
    
    image = lineExtract(imb);