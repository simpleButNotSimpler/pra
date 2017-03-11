function image = edgeresponse(im, resp)
        %cmfrat filters 0, 20, 40, 60, 80, 100, 120, 140, 160
        f0 = cmfrat(11, 11, 0);
        f20 = cmfrat(11, 11, 20);
        f40 = cmfrat(11, 11, 40);
        f60 = cmfrat(11, 11, 60);
        f80 = cmfrat(11, 11, 80);
        f100 = cmfrat(11, 11, 100);
        f120 = cmfrat(11, 11, 120);
        f140 = cmfrat(11, 11, 140);
        f160 = cmfrat(11, 11, 160);

        im0 = imfilter(im, f0, 'symmetric');
        im20 = imfilter(im, f20, 'symmetric');
        im40 = imfilter(im, f40, 'symmetric');
        im60 = imfilter(im, f60, 'symmetric');
        im80 = imfilter(im, f80, 'symmetric');
        im100 = imfilter(im, f100, 'symmetric');
        im120 = imfilter(im, f120, 'symmetric');
        im140 = imfilter(im, f140, 'symmetric');
        im160 = imfilter(im, f160, 'symmetric');

        %combined the images
        if strcmp(resp, 'max')
            image = maxresponse(im0, im20, im40, im60, im80, im100, im120, im140, im160);
        else
            image = minresponse(im0, im20, im40, im60, im80, im100, im120, im140, im160);
        end
        
        image = imadjust(image);
        
%         figure('units','normalized','outerposition',[0 0 1 1]);
% %         set(gcf,'Visible','Off');
%         subplot(3, 4, 1), imshow(image), title('combined'); hold on;
%         subplot(3, 4, 2), imshow(im0), title('0 deg');
%         subplot(3, 4, 3), imshow(im20), title('20 deg');
%         subplot(3, 4, 4), imshow(im40), title('40 deg');
%         subplot(3, 4, 5), imshow(im60), title('60 deg');
%         subplot(3, 4, 6), imshow(im80), title('80 deg');
%         subplot(3, 4, 7), imshow(im100), title('100 deg');
%         subplot(3, 4, 8), imshow(im120), title('120 deg');
%         subplot(3, 4, 9), imshow(im140), title('140 deg');
%         subplot(3, 4, 10), imshow(im160), title('160 deg');
%         hold off;
end