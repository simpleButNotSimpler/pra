function testallresppair()
    close all;
    srcFiles = dir('colorpics\*.JPG');  % the folder in which ur images exists
    for i = 1:2:length(srcFiles) - 1
        filename1 = strcat('colorpics\',srcFiles(i).name);
        filename2 = strcat('colorpics\',srcFiles(i + 1).name);
        im1 = imread(filename1);
        im2 = imread(filename2);

        allresppair(im1, im2, i);
    end
    display('Done!');
end

function allresppair(im1, im2, idx)

    imb1 = im2double(rgb2gray(im1));
    imb2 = im2double(rgb2gray(im2));
    
    %edge response
    imfirstedge1 = edgeresponse(imb1, 'max'); 
    imfirstedge2 = edgeresponse(imb2, 'max'); 

    imsecondedge1 = edgeresponse(imcomplement(imfirstedge1), 'max');
    imsecondedge2 = edgeresponse(imcomplement(imfirstedge2), 'max');
    
    %canny
    %first im
    tlow1 = percentile(imfirstedge1, 12); %threshold
    thigh1 = percentile(imfirstedge1, 5); %threshold
    [imfirstcanny1, ~] = cannys(imfirstedge1, tlow1, thigh1);
    
    tlow2 = percentile(imfirstedge2, 12); %threshold
    thigh2 = percentile(imfirstedge2, 5); %threshold
    [imfirstcanny2, ~] = cannys(imfirstedge2, tlow2, thigh2);
    
    %second im
    tlow1 = percentile(imsecondedge1, 60); %threshold
    thigh1 = percentile(imsecondedge1, 20); %threshold
    [imsecondcanny1, ~] = cannys(imsecondedge1, tlow1, thigh1);
    
    tlow2 = percentile(imsecondedge2, 60); %threshold
    thigh2 = percentile(imsecondedge2, 20); %threshold
    [imsecondcanny2, ~] = cannys(imsecondedge2, tlow2, thigh2);
    
    %plotting
    figure('units','normalized','outerposition',[0 0 1 1]);
    set(gcf,'Visible','Off');
    
    subplot(3, 5, 1), imshow(imb1), title('original'); hold on;
    subplot(3, 5, 2), imshow(imfirstedge1), title('1st e-resp');
    subplot(3, 5, 3), imshow(imsecondedge1), title('2nd e-resp');
    subplot(3, 5, 4), imshow(imfirstcanny1), title('1st canny');
    subplot(3, 5, 5), imshow(imsecondcanny1), title('2nd canny'); 
    subplot(3, 5, 6), imshow(imb2), title('original');
    subplot(3, 5, 7), imshow(imfirstedge2), title('1st e-resp');
    subplot(3, 5, 8), imshow(imsecondedge2), title('2nd e-resp');
    subplot(3, 5, 9), imshow(imfirstcanny2), title('1st canny');
    subplot(3, 5, 10), imshow(imsecondcanny2), title('2nd canny');
    hold off;

    % save the plot
    fname = strcat('/imdemo/mixedpair/person', num2str(idx), '.png');
    saveas(gcf,[pwd fname]);
end
