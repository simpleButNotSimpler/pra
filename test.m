    im1 = mfratfilter(imread('pics/01.bmp'));
%     im1 = im2bw(im1, 0.8245);
    im2 = mfratfilter(imread('pics/02.bmp'));
    im3 = mfratfilter(imread('pics/03.bmp'));
    im4 = mfratfilter(imread('pics/04.bmp'));
    im5 = mfratfilter(imread('pics/05.bmp'));
    im6 = mfratfilter(imread('pics/06.bmp'));
    im7 = mfratfilter(imread('pics/07.bmp'));
    im8 = mfratfilter(imread('pics/08.bmp'));

    subplot(2, 4, 1), imshow(im1);
    hold on
    subplot(2, 4, 2), imshow(im2), subplot(2, 4, 3), imshow(im3), subplot(2, 4, 4), imshow(im4);
    subplot(2, 4, 5), imshow(im5), subplot(2, 4, 6), imshow(im6), subplot(2, 4, 7), imshow(im7);
    subplot(2, 4, 8), imshow(im8);