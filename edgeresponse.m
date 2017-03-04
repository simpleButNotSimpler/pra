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

        im0 = imfilter(im, f0);
        im20 = imfilter(im, f20);
        im40 = imfilter(im, f40);
        im60 = imfilter(im, f60);
        im80 = imfilter(im, f80);
        im100 = imfilter(im, f100);
        im120 = imfilter(im, f120);
        im140 = imfilter(im, f140);
        im160 = imfilter(im, f160);

        %combined the images
        if strcmp(resp, 'max')
            image = maxresponse(im0, im20, im40, im60, im80, im100, im120, im140, im160);
        else
            image = minresponse(im0, im20, im40, im60, im80, im100, im120, im140, im160);
        end
        
%        image = imadjust(image);
end