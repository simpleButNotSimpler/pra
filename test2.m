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
    im1 = imread('IMG_004 (5).JPG');
%     im1 = imread('IMG_005 (5).JPG');
%     im1 = imread('IMG_005 (6).JPG');

    %extract the layers
    imr = im1(:, :, 1);
    img = im1(:, :, 2);
    imb = im2double(im1(:, :, 3));
    imgray = rgb2gray(im1);
    
    imb = im2double(imgray);
    
    %edge response
    imfirstedge = edgeresponse(imb, 'max'); 
    imfirstedge = imadjust(imfirstedge);
    imsecondedge = edgeresponse(imcomplement(imfirstedge), 'max');
    imsecondedge = imadjust(imsecondedge);
    
    %threshold    
    
    %binarized
%     image_bin = im2bw(imsecondedge, 0.8);
%     imshow(image_bin), title('bin');
    
    imshow(imb), title('original');
    
    %canny
    tlow = percentile(imfirstedge, 60);
    thigh = percentile(imfirstedge, 90);
    
    imc = cannys(imfirstedge, tlow, thigh);
    figure, imshowpair(imfirstedge, imc, 'montage');
    
    %%  this section is to test additional feature
    %get the end points
   xindex = [];
   yindex = [];
   [row, col] = size(imc);
   index = 0;
   for t=2:row - 1
       for k=2:col-1
           %number of white pics in the neighborhood
             nwsquare = size(find(imc([t-1, t, t+1], [k-1, k, k+1]) == 1), 1);
             mat = [imc([t-1, t, t+1], k-1)', imc(t+1, [k, k+1]), imc([t, t-1], k+1)', imc(t-1, [k, k-1])];
             nwcirc = transb2w(mat);

            if nwsquare == 2 && imc(t, k) == 1 || ...
               (nwsquare == 3 && nwcirc == 1 && imc(t, k) == 1) %end of condition statement
                index = index + 1;
                xindex(index) = t;
                yindex(index) = k;
            end
       end
   end    

   %find the closest point
   points = [xindex', yindex'];
   idx = closestpoints(points, points);

   %apply threshold on closest points
   th = 5;
   idx = idx(idx(:, 2) < th, :);
   corr = points(idx(:, 3), :);

%connect the endpoints   
   figure, imshow(imc); hold on;
   scatter(corr(:, 2), corr(:, 1), 'filled');
   hold off;

%    figure, imshow(imtemp);