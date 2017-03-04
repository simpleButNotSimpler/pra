function testallresp()
    srcFiles = dir('colorpics\*.JPG');  % the folder in which ur images exists
    for i = 1:length(srcFiles)
        filename1 = strcat('colorpics\',srcFiles(i).name);
        im1 = imread(filename1);
        
        allresp(im1, i);
    end
    display('Done!');
end

function allresp(im1, idx)
    close all;

    %convert to grayscale   
    imb = im2double(rgb2gray(im1));
    
    %edge response
    imfirstedge = edgeresponse(imb, 'max'); 
    imsecondedge = edgeresponse(imcomplement(imfirstedge), 'max');
    temp = imcomplement(imsecondedge);
%     imthirdedge = edgeresponse(imcomplement(imsecondedge*0.4), 'max');
    imthirdedge = edgeresponse(temp, 'max');
    
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
    tlow = percentile(imthirdedge, 60);
    thigh = percentile(imthirdedge, 40);
    [imthirdcanny, ~] = cannys(imthirdedge, tlow, thigh);    
    
    %plotting
    figure('units','normalized','outerposition',[0 0 1 1]);
    set(gcf,'Visible','Off');
    subplot(3, 4, 1), imshow(imb), title('original'); hold on;
    subplot(3, 4, 2), imshow(imfirstedge), title('1st e-resp');
    subplot(3, 4, 3), imshow(imsecondedge), title('2nd e-resp');
    subplot(3, 4, 4), imshow(imthirdedge), title('3rd e-resp');
    subplot(3, 4, 6), imshow(imfirstcanny), title('1st canny');
    subplot(3, 4, 7), imshow(imsecondcanny), title('2nd canny');
    subplot(3, 4, 8), imshow(imthirdcanny), title('3rd canny');
    hold off;

    % save the plot
    fname = strcat('/imdemo/mixed/person', num2str(idx), '.png');
    saveas(gcf,[pwd fname]);
end