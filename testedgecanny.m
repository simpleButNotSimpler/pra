function testedgecanny()
    close all;
    srcFiles = dir('colorpics\*.JPG');  % the folder in which ur images exists
    for i = 1:2:length(srcFiles) - 1
        filename1 = strcat('colorpics\',srcFiles(i).name);
        filename2 = strcat('colorpics\',srcFiles(i + 1).name);
        im1 = imread(filename1);
        im2 = imread(filename2);

        pairedge(im1, im2, i);
    end
    display('Done!');
end

function pairedge(im1, im2, idx)
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
%     figure('units','normalized','outerposition',[0 0 1 1]);
%     set(gcf,'Visible','Off');
%     subplot(3, 4, 1), imshow(imb1), title('original'); hold on;
%     subplot(3, 4, 2), imshow(imfirstedge1), title('1st e-resp');
%     subplot(3, 4, 3), imshow(imsecondedge1), title('2nd e-resp');
%     subplot(3, 4, 4), imshow(imthirdedge1), title('3rd e-resp canny');
%     subplot(3, 4, 5), imshow(imb2), title('original');
%     subplot(3, 4, 6), imshow(imfirstedge2), title('1st e-resp');
%     subplot(3, 4, 7), imshow(imsecondedge2), title('2nd e-resp');
%     subplot(3, 4, 8), imshow(imthirdedge2), title('3rd e-resp canny');
    
    %canny
    figure('units','normalized','outerposition',[0 0 1 1]);
    set(gcf,'Visible','Off');
    subplot(3, 4, 1), imshow(imb1), title('original'); hold on;
    subplot(3, 4, 2), imshow(imfirstcanny1), title('1st e-resp');
    subplot(3, 4, 3), imshow(imfirstcanny2), title('2nd e-resp');
    subplot(3, 4, 4), imshow(imfirstcanny3), title('3rd e-resp canny');
    subplot(3, 4, 5), imshow(imb2), title('original');
    subplot(3, 4, 6), imshow(imsecondcanny1), title('1st e-resp');
    subplot(3, 4, 7), imshow(imsecondcanny2), title('2nd e-resp');
    subplot(3, 4, 8), imshow(imsecondcanny3), title('3rd e-resp canny');

 % save the plot
 fname = strcat('/imdemo/canny/person', num2str(idx), '.png');
 saveas(gcf,[pwd fname]);
end
    