function testmixedfilter()
    resp = testnthedge();
    display('nthedge done!!!');
    
    for idx=1:10
        mixedfilter(resp(:,:, :, idx), idx);
    end
    
    display('mixed filter done!!!');
end

function mixedfilter(resp, idx)
    close all;
    
    %plotting
    figure('units','normalized','outerposition',[0 0 1 1]);
    set(gcf,'Visible','Off');
    
    for t = 1:15
        temp = imcomplement(resp(:,:,t));
        temp = oldedgeresponse(temp, 'max');
        subplot(4, 4, t), imshow(temp);
    end

    % save the plot
    fname = strcat('/imdemo/mixedfilter/person', num2str(idx), '.png');
    saveas(gcf,[pwd fname]);
end