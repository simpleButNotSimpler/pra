function image = normalize(im)
    im = double(im); %// Cast to double
    minvalue = min(im(:)); %// Note the change here
    maxvalue = mean(im(:)); %// Got rid of superfluous nested min/max calls
    image = uint8((im-minvalue)*255/(maxvalue-minvalue)); %// Cast back to uint8
end