function image = lineExtract(im)
    im = im2double(im);
    
    f0 = [0 0 0 0 0; 0 0 0 0 0; 1 1 1 1 1; 0 0 0 0 0; 0 0 0 0 0] / 5;
    f45 = [1 0 0 0 0; 0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1] / 5;
    f90 = [0 0 1 0 0; 0 0 1 0 0; 0 0 1 0 0; 0 0 1 0 0; 0 0 1 0 0] / 5;
    f135 = [0 0 0 0 1; 0 0 0 1 0; 0 0 1 0 0; 0 1 0 0 0; 1 0 0 0 0] / 5;

    figure1 = figure('Position', [100, 100, 1024, 1200]);
    %subplot
    subplot(5, 4, 1), imshow(im); hold on;
    title('original');    
    
    %normalization
    low = stretchlim(im) + [-0.1; 0.1];
    im0 = imadjust(im, low, [0 1]);
%     im0 = im;
    subplot(5, 4, 2), imshow(im0);
    title('normalized');
    
    %make 4 copy of the images
    im45 = im0;
    im90 = im0;
    im135 = im0;
    
    %median filter
    im0 = medfilt2(im0);
    subplot(5, 4, 3), imshow(im0);
    title('median filter (0 deg image)');
    
    %fi filters
    im0 = filter2(im0, f0, 'full');
    im45 = filter2(im45, f45, 'full');
    im90 = filter2(im90, f90, 'full');
    im135 =filter2(im135, f135, 'full');
    
    subplot(5, 4, 5), imshow(im0);
    title('0 deg filter');
    subplot(5, 4, 6), imshow(im45);
    title('45 deg filter');
    subplot(5, 4, 7), imshow(im90);
    title('90 deg filter');
    subplot(5, 4, 8), imshow(im135);
    title('135 deg filter');
    
    %bottom hot
    len = 7;
    s0 = strel('line', len, 0);
    s45 = strel('line', len, 45);
    s90 = strel('line', len, 90);
    s135 = strel('line', len, 135);
    
    im0 = imbothat(im0, s0);
    im0 = imadjust(im0);
    im45 = imbothat(im45, s45);
    im45 = imadjust(im45);
    im90 = imbothat(im90, s90);
    im90 = imadjust(im90);
    im135 = imbothat(im135, s135);
    im135 = imadjust(im135);
    
    subplot(5, 4, 9), imshow(im0);
    title('bottom hat 0 deg');
    subplot(5, 4, 10), imshow(im45);
    title('bottom hat 45 deg');
    subplot(5, 4, 11), imshow(im90);
    title('bottom hat 90 deg');
    subplot(5, 4, 12), imshow(im135);
    title('bottom hat 135 deg');
    
    %combine the different images
    image = imfuse(im0,im90);
    image = imfuse(image,im45);
    image = imfuse(image,im135);
%     image = (im0 + im45 + im90 + im135) / 4;
    subplot(5, 4, 13), imshow(image);
    title('combined image');
    image =rgb2gray(image);
    subplot(5, 4, 14), imshow(image);
    title('to gray');
    
    %remove some noise
    m = mean(image(:));
    [row, col] = find(image <= 3*m);
    idx = sub2ind(size(image), row, col);
    image(idx) = 0;
    image = imadjust(image);
    subplot(5, 4, 15), imshow(image);
    title('noise removed');
%     figure, imshowpair(C, Ctemp, 'montage');
    
    %binarize image
    cbin = ones(size(image));
    m = mean(image(:));
    [row, col] = find(image <= m);
    idx = sub2ind(size(image), row, col);
    cbin(idx) = 0;
    subplot(5, 4, 16), imshow(cbin);
    title('binarized');
%     figure, imshow(cbin);
    
    %remove spikes
    image = remspikes(cbin, 8);
    image = imrotate(image, -180);
    subplot(5, 4, 17), imshow(image);
    title('cleaned');
%     figure, imshowpair(cbin, cfinal, 'montage'); 

    tightfig;
    
end