close all;
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
%     im1 = imread('IMG_004 (4).JPG');
%     im1 = imread('IMG_004 (5).JPG');
%     im1 = imread('IMG_005 (5).JPG');
    im1 = imread('IMG_005 (6).JPG');

    %extract the layers    
    imb = im2double(rgb2gray(im1));
    
    %edge response
    imfirstedge = edgeresponse(imb, 'max'); 
    imsecondedge = edgeresponse(imcomplement(imfirstedge), 'max');
    imthirdedge = edgeresponse(imcomplement(imsecondedge), 'max');
    
    %canny
    %first
    tlow = percentile(imfirstedge, 12);
    thigh = percentile(imfirstedge, 5);
    [imfirstcanny, ~] = cannys(imfirstedge, tlow, thigh);
    
    %second
    tlow = percentile(imsecondedge, 40);
    thigh = percentile(imsecondedge, 20);
    [imsecondcanny, ~] = cannys(imsecondedge, tlow, thigh);
    
    %third
    tlow = percentile(imthirdedge, 90);
    thigh = percentile(imthirdedge, 70);
    [imthirdcanny, ~] = cannys(imthirdedge, tlow, thigh);    
    
    figure;
    subplot(2, 4, 1), imshow(imb), title('original'); hold on;
    subplot(2, 4, 2), imshow(imfirstedge), title('1st e-resp');
    subplot(2, 4, 3), imshow(imsecondedge), title('2nd e-resp');
    subplot(2, 4, 4), imshow(imthirdedge), title('3rd e-resp');
    subplot(2, 4, 6), imshow(imfirstcanny), title('1st canny');
    subplot(2, 4, 7), imshow(imsecondcanny), title('2nd canny');
    subplot(2, 4, 8), imshow(imthirdcanny), title('3rd canny');
    hold off;

%     saveas(gcf,'person1 - im1.png');
%     saveas(gcf,[pwd '/imdemo/person5 - im2.png']);