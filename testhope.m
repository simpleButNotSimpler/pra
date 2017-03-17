%get image
[path, name] = uigetfile('*');
im = imread(strcat(name, path));
im = im2double(rgb2gray(im));
im = imcomplement(im);

%get the 8 angles response
resp = edgeresponseinit(im);

%get the filters
filter = zeros(15, 15, 9);
angle = 0;
for t=1:9
    filter(:,:, t) = cmfrat(11, 11, angle);
    angle = angle + 20;
end

%apply the filters n times in each direction
ntimes = 10;
images = zeros(160, 160, ntimes, 9);
angle = 0;
for t=1:9
    pathname = strcat('/hope-pics-no-norm/im', num2str(angle), '.png');
    images(:,:,:,t) = nthfilter(resp(:,:, t), filter(:,:,t), pathname, ntimes);
    angle = angle + 20;
end

% %get the max from all the filters per iteration
% for t=1:ntimes
%     temp = images(:,:,t,:);
%     maximum = max(temp(:));
%     images(:,:,t,:) = images(:,:,t,:) / maximum;
% end

%get the maximum response from the images and display them
close gcf;
figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'Visible','Off');

subplot(3, 4, 1), imshow(imcomplement(im));
result = zeros(160, 160, ntimes);
for t=1:ntimes
    result(:,:, t) = immax(images(:,:,t,:));
    subplot(3, 4, t+1), imshow(imadjust(result(:,:,t)));
end
saveas(gcf, [pwd '/hope-pics-no-norm/combined.png']);
close gcf;