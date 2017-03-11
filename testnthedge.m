function resp = testnthedge()
    srcFiles = dir('colorpics\*.JPG');  % the folder in which ur images exists
    resp = zeros(160, 160, 15, 10);
    for i = 1:length(srcFiles)
        filename1 = strcat('colorpics\',srcFiles(i).name);
        im1 = imread(filename1);
        
        resp(:, :, :, i) = nthedge(im1, i);
    end
    display('Done!');
end

function resp = nthedge(im1, idx)
    close all;

    %convert to grayscale   
    imb = im2double(rgb2gray(im1));
    imb = imcomplement(imb);
%   imb = im2double(im1(:,:,3));    

    resp = zeros(160, 160, 15);
    resp(:,:,1) = edgeresponse(imb, 'max');
    
    %plotting
    figure('units','normalized','outerposition',[0 0 1 1]);
    set(gcf,'Visible','Off');
    
    subplot(4, 4, 1), imshow(imcomplement(imb));
    subplot(4, 4, 2), imshow(resp(:,:,1));
    
    for t = 2:15
        resp(:,:,t) = edgeresponse(resp(:,:,t-1), 'max');
        subplot(4, 4, t+1), imshow(resp(:,:,t));
    end

    % save the plot
    fname = strcat('/imdemo/nthedge/person', num2str(idx), '.png');
    saveas(gcf,[pwd fname]);
end