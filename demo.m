fixed = imread('imtest1.png');
fixed = rgb2gray(fixed);
fixed = im2bw(fixed, 0);

% moving = imrotate(fixed, 50);
% moving = imread('imtest1-scaledown.png');
% moving = rgb2gray(moving);
% moving = im2bw(moving, 0);


%test scaled-down image
% moving = imresize(fixed, 0.5);
% moving = imrotate(moving, 10);
% moving = imresize(moving, size(fixed));

%test image with noise
% moving = fixed;
moving = imrotate(fixed, 10);
noise = zeros(size(moving));
row = randi([1, size(moving, 1)], 2*size(moving, 1), 1);
column = randi([1, size(moving, 2)], 2*size(moving, 2), 1);
index = sub2ind(size(moving), row, column);
moving(index) = 1;

imshow(moving);


%retrieve the coordinate of the lines
[mrow, mcolumn] = find(moving == 1);
[frow, fcolumn] = find(fixed == 1);

M = [mrow, mcolumn];
F = [frow, fcolumn];

%run the icp
[R, T, reg, angle, er] = icp(M, F, 100, 0.00001, 0);

%create a picture
reg = uint8(ceil(reg));
[row, column] = find(reg == 0);
idx = sub2ind(size(reg), row, column);
reg(idx) = 1;

n = size(reg, 1);
I = zeros(size(fixed));
for t=1:n
    I(reg(t, 1), reg(t, 2)) = 1;
end

%display the two registration
figure;
subplot(1,2,1);
imshowpair(moving, fixed);

subplot(1,2,2);
imshowpair(I, fixed);
