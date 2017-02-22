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
    im1 = imread('IMG_001 (1).JPG');
    im2 = imread('IMG_001 (2).JPG');
%     im1 = imread('IMG_002 (2).JPG');
%     im2 = imread('IMG_002 (3).JPG');
%     im1 = imread('IMG_003 (3).JPG');
%     im2 = imread('IMG_003 (4).JPG');
%     im1 = imread('IMG_004 (4).JPG');
%     im2 = imread('IMG_004 (5).JPG');
%     im1 = imread('IMG_005 (5).JPG');
%     im2 = imread('IMG_005 (6).JPG');

    %extract the layers
%     imr = im1(:, :, 1);
%     img = im1(:, :, 2);
%     imb = im2double(im1(:, :, 3));
    imgray = rgb2gray(im1);
    
    imb1 = im2double(rgb2gray(im1));
    imb2 = im2double(rgb2gray(im2));
    
    %edge response
    imfirstedge1 = edgeresponse(imb1, 'max'); 
    imfirstedge2 = edgeresponse(imb2, 'max'); 

    imsecondedge1 = edgeresponse(imcomplement(imfirstedge1), 'max');
    imsecondedge2 = edgeresponse(imcomplement(imfirstedge2), 'max');
    
    %canny
    %first im
    tlow1 = percentile(imfirstedge1, 12);
    thigh1 = percentile(imfirstedge1, 5);
    [imfirstcanny1, ~] = cannys(imfirstedge1, tlow1, thigh1);
    
    tlow2 = percentile(imfirstedge2, 12);
    thigh2 = percentile(imfirstedge2, 5);
    [imfirstcanny2, ~] = cannys(imfirstedge2, tlow2, thigh2);
    
    %second im
    tlow1 = percentile(imsecondedge1, 60);
    thigh1 = percentile(imsecondedge1, 20);
    [imsecondcanny1, ~] = cannys(imsecondedge1, tlow1, thigh1);
    
    tlow2 = percentile(imsecondedge2, 60);
    thigh2 = percentile(imsecondedge2, 20);
    [imsecondcanny2, ~] = cannys(imsecondedge2, tlow2, thigh2);
    
    
    figure;
%     set(gcf, 'PaperOrientation', 'portrait');
    subplot(2, 5, 1), imshow(imb1), title('original'); hold on;
    subplot(2, 5, 2), imshow(imfirstedge1), title('1st e-resp');
    subplot(2, 5, 3), imshow(imsecondedge1), title('2nd e-resp');
    subplot(2, 5, 4), imshow(imfirstcanny1), title('1st e-resp canny');
    subplot(2, 5, 5), imshow(imsecondcanny1), title('2nd e-resp canny'); 
    subplot(2, 5, 6), imshow(imb2), title('original');
    subplot(2, 5, 7), imshow(imfirstedge2), title('1st e-resp');
    subplot(2, 5, 8), imshow(imsecondedge2), title('2nd e-resp');
    subplot(2, 5, 9), imshow(imfirstcanny2), title('1st e-resp canny');
    subplot(2, 5, 10), imshow(imsecondcanny2), title('2nd e-resp canny');
    hold off;

%     saveas(gcf,'person1 - im1.png');
%     saveas(gcf,[pwd '/imdemo/person5-im1-&-im2.png']);
      
    
    %%  this section is to test additional feature
    %get the end points
%    xindex = [];
%    yindex = [];
%    [row, col] = size(imc);
%    index = 0;
%    for t=2:row - 1
%        for k=2:col-1
%            %number of white pics in the neighborhood
%              nwsquare = size(find(imc([t-1, t, t+1], [k-1, k, k+1]) == 1), 1);
%              mat = [imc([t-1, t, t+1], k-1)', imc(t+1, [k, k+1]), imc([t, t-1], k+1)', imc(t-1, [k, k-1])];
%              nwcirc = transb2w(mat);
% 
%             if nwsquare == 2 && imc(t, k) == 1 || ...
%                (nwsquare == 3 && nwcirc == 1 && imc(t, k) == 1) %end of condition statement
%                 index = index + 1;
%                 xindex(index) = t;
%                 yindex(index) = k;
%             end
%        end
%    end    

   %find the closest point
%    points = [xindex', yindex'];
%    idx = closestpoints(points, points);
% 
%    %apply threshold on closest points
%    th = 5;
%    idx = idx(idx(:, 2) < th, :);
%    corr = points(idx(:, 3), :);

%connect the endpoints   
%    figure, imshow(imc); hold on;
%    scatter(corr(:, 2), corr(:, 1), 'filled');
%    hold off;

%    figure, imshow(imtemp);