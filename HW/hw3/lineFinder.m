function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
    theta_num_bins=size(hough_img,2);
    step = 180/theta_num_bins;  
    fh = figure; 
    imshow(orig_img);
    hold on;    
    for i = 1 : size(hough_img,1)
        for j = 1 : size(hough_img,2)
            if hough_img(i, j) > hough_threshold
                theta = i * 180 / size(hough_img,1);
                rho = sqrt(size(orig_img,1)^2 + size(orig_img,2)^2);
                rho = rho * (j / (size(hough_img,2) / 2) - 1);
                x = 1 : size(orig_img,1);
                y = x * sind(theta)/cosd(theta) + rho /cosd(theta);
                line(y,x, 'LineWidth',0.7, 'Color','red');
                step=step+1;
            end 
        end
    end
    line_detected_img = saveAnnotatedImg(fh);
end

function annotated_img = saveAnnotatedImg(fh)
    figure(fh); % Shift the focus back to the figure fh

    % The figure needs to be undocked
    set(fh, 'WindowStyle', 'normal');

    % The following two lines just to make the figure true size to the
    % displayed image. The reason will become clear later.
    img = getimage(fh);
    truesize(fh, [size(img, 1), size(img, 2)]);

    % getframe does a screen capture of the figure window, as a result, the
    % displayed figure has to be in true size. 
    frame = getframe(fh);
    frame = getframe(fh);
    pause(0.5); 
    % Because getframe tries to perform a screen capture. it somehow 
    % has some platform depend issues. we should calling
    % getframe twice in a row and adding a pause afterwards make getframe work
    % as expected. This is just a walkaround. 
    annotated_img = frame.cdata;
end