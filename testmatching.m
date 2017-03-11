function testmatching()
    srcFiles = dir('colorpics\*.JPG');  % the folder in which ur images exists
    for i = 1:2:length(srcFiles) - 1
        filename1 = strcat('colorpics\',srcFiles(i).name);
        filename2 = strcat('colorpics\',srcFiles(i + 1).name);
        im1 = imread(filename1);
        im2 = imread(filename2);

        pointmatching(im1, im2, i);
    end
    display('Done!');
end

function pointmatching(imb1, imb2, idx)

    close all;
    %extract the layers
    imb1 = im2double(rgb2gray(imb1));
    imb2 = im2double(rgb2gray(imb2));
    
    %edge response
    imfirstedge1 = edgeresponse(imb1, 'max'); 
    imfirstedge2 = edgeresponse(imb2, 'max'); 

    imsecondedge1 = edgeresponse(imcomplement(imfirstedge1), 'max');
    imsecondedge2 = edgeresponse(imcomplement(imfirstedge2), 'max');
    
    imthirdedge1 = edgeresponse(imcomplement(imsecondedge1), 'max');
    imthirdedge2 = edgeresponse(imcomplement(imsecondedge2), 'max');
    
    %canny
%     %first im
%     tlow1 = percentile(imfirstedge1, 12);
%     thigh1 = percentile(imfirstedge1, 5);
%     [imfirstcanny1, ~] = cannys(imfirstedge1, tlow1, thigh1);
%     
%     tlow2 = percentile(imsecondedge1, 40);
%     thigh2 = percentile(imsecondedge1, 20);
%     [imfirstcanny2, ~] = cannys(imsecondedge1, tlow2, thigh2);
%     
%     tlow3 = percentile(imthirdedge1, 90);
%     thigh3 = percentile(imthirdedge1, 70);
%     [imfirstcanny3, ~] = cannys(imthirdedge1, tlow3, thigh3);
%     
%     %second im
%     tlow1 = percentile(imfirstedge2, 12);
%     thigh1 = percentile(imfirstedge2, 5);
%     [imsecondcanny1, ~] = cannys(imfirstedge2, tlow1, thigh1);
%     
%     tlow2 = percentile(imsecondedge2, 40);
%     thigh2 = percentile(imsecondedge2, 20);
%     [imsecondcanny2, ~] = cannys(imsecondedge2, tlow2, thigh2);
%     
%     tlow3 = percentile(imthirdedge2, 90);
%     thigh3 = percentile(imthirdedge2, 70);
%     [imsecondcanny3, ~] = cannys(imthirdedge2, tlow3, thigh3);
    
  %match points in the image
  figure('units','normalized','outerposition',[0 0 1 1]);
  set(gcf,'Visible','Off');
  %first e-resp
  [mp11, mp21, points11, points21] = getmp(imfirstedge1, imfirstedge2);
  subplot(3, 4, 10), showMatchedFeatures(imfirstedge1, imfirstedge2, mp11, mp21);
  
   %second e-resp
  [mp12, mp22, points12, points22] = getmp(imsecondedge1, imsecondedge2);
  subplot(3, 4, 11), showMatchedFeatures(imsecondedge1, imsecondedge2, mp12, mp22);
   
   %third e-resp
  [mp13, mp23, points13, points23] = getmp(imthirdedge1, imthirdedge2);
  subplot(3, 4, 12), showMatchedFeatures(imthirdedge1, imthirdedge2, mp13, mp23);
    
    
    %plot
    subplot(3, 4, 1), imshow(imb1), title('original'); hold on;
    subplot(3, 4, 2), imshow(imfirstedge1), title('1st e-resp'), hold on; points11.plot %mp11.plot ;
    subplot(3, 4, 3), imshow(imsecondedge1), title('2nd e-resp'), hold on; points12.plot %mp12.plot;
    subplot(3, 4, 4), imshow(imthirdedge1), title('3rd e-resp'), hold on; points13.plot %mp13.plot;
    subplot(3, 4, 5), imshow(imb2), title('original');
    subplot(3, 4, 6), imshow(imfirstedge2), title('1st e-resp'), hold on; points21.plot %mp21.plot;
    subplot(3, 4, 7), imshow(imsecondedge2), title('2nd e-resp'), hold on; points22.plot %mp22.plot;
    subplot(3, 4, 8), imshow(imthirdedge2), title('3rd e-resp'), hold on; points23.plot %mp23.plot;
    hold off;
    
    % save the plot
    fname = strcat('/imdemo/matchtest/person', num2str(idx), '.png');
    saveas(gcf,[pwd fname]);
end