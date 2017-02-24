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
%     im2 = imread('IMG_001 (2).JPG');
%     im1 = imread('IMG_002 (2).JPG');
    im2 = imread('IMG_002 (3).JPG');
    im1 = imread('IMG_003 (3).JPG');
%     im2 = imread('IMG_003 (4).JPG');
%     im1 = imread('IMG_004 (4).JPG');
%     im2 = imread('IMG_004 (5).JPG');
%     im1 = imread('IMG_005 (5).JPG');
%     im2 = imread('IMG_005 (6).JPG');

    %extract the layers
    imb1 = im2double(rgb2gray(im1));
    imb2 = im2double(rgb2gray(im2));
    
    %edge response
    imfirstedge1 = edgeresponse(imb1, 'max'); 
    imfirstedge2 = edgeresponse(imb2, 'max'); 

    imsecondedge1 = edgeresponse(imcomplement(imfirstedge1), 'max');
    imsecondedge2 = edgeresponse(imcomplement(imfirstedge2), 'max');
    
    imthirdedge1 = edgeresponse(imcomplement(imsecondedge1), 'max');
    imthirdedge2 = edgeresponse(imcomplement(imsecondedge2), 'max');
    
    %canny
    %first im
    tlow1 = percentile(imfirstedge1, 12);
    thigh1 = percentile(imfirstedge1, 5);
    [imfirstcanny1, ~] = cannys(imfirstedge1, tlow1, thigh1);
    
    tlow2 = percentile(imsecondedge1, 40);
    thigh2 = percentile(imsecondedge1, 20);
    [imfirstcanny2, ~] = cannys(imsecondedge1, tlow2, thigh2);
    
    tlow3 = percentile(imthirdedge1, 90);
    thigh3 = percentile(imthirdedge1, 70);
    [imfirstcanny3, ~] = cannys(imthirdedge1, tlow3, thigh3);
    
    %second im
    tlow1 = percentile(imfirstedge2, 12);
    thigh1 = percentile(imfirstedge2, 5);
    [imsecondcanny1, ~] = cannys(imfirstedge2, tlow1, thigh1);
    
    tlow2 = percentile(imsecondedge2, 40);
    thigh2 = percentile(imsecondedge2, 20);
    [imsecondcanny2, ~] = cannys(imsecondedge2, tlow2, thigh2);
    
    tlow3 = percentile(imthirdedge2, 90);
    thigh3 = percentile(imthirdedge2, 70);
    [imsecondcanny3, ~] = cannys(imthirdedge2, tlow3, thigh3);
    
    %edge
%     figure;
%     subplot(2, 4, 1), imshow(imb1), title('original'); hold on;
%     subplot(2, 4, 2), imshow(imfirstedge1), title('1st e-resp');
%     subplot(2, 4, 3), imshow(imsecondedge1), title('2nd e-resp');
%     subplot(2, 4, 4), imshow(imthirdedge1), title('3rd e-resp canny');
%     subplot(2, 4, 5), imshow(imb2), title('original');
%     subplot(2, 4, 6), imshow(imfirstedge2), title('1st e-resp');
%     subplot(2, 4, 7), imshow(imsecondedge2), title('2nd e-resp');
%     subplot(2, 4, 8), imshow(imthirdedge2), title('3rd e-resp canny');
%     hold off;
    
    %canny
    figure;
    subplot(2, 4, 1), imshow(imb1), title('original'); hold on;
    subplot(2, 4, 2), imshow(imfirstcanny1), title('1st e-resp');
    subplot(2, 4, 3), imshow(imfirstcanny2), title('2nd e-resp');
    subplot(2, 4, 4), imshow(imfirstcanny3), title('3rd e-resp canny');
    subplot(2, 4, 5), imshow(imb2), title('original');
    subplot(2, 4, 6), imshow(imsecondcanny1), title('1st e-resp');
    subplot(2, 4, 7), imshow(imsecondcanny2), title('2nd e-resp');
    subplot(2, 4, 8), imshow(imsecondcanny3), title('3rd e-resp canny');
    hold off;

%     saveas(gcf,'person1 - im1.png');
%     saveas(gcf,[pwd '/imdemo/person5-im1-&-im2.png']);