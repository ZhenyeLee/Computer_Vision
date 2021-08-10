function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)
    edge_img = im2double(edge(orig_img, 'canny',  0.05));
    img = bwmorph(edge_img, 'dilate', 2);
    max_rho = sqrt(size(orig_img,1)^2 + size(orig_img,2)^2);
    fh = figure; 
    imshow(orig_img);
    hold on;    
    for theta = 1 : size(hough_img,1)
        for rho = 1 : size(hough_img,2)
            if hough_img(theta, rho) > hough_threshold
                rho_val = max_rho * (rho / (size(hough_img,2) / 2) - 1);                
                theta_val = theta * 180 / size(hough_img,1);
                x = 1;
                while x <= size(orig_img,1)
                    y = (x * sind(theta_val)/cosd(theta_val) + rho_val/cosd(theta_val));
                    yround = round(y);
                    X = [0,0];
                    Y = [0,0];
                    if yround > 0 && yround < size(orig_img,2) && img(round(x), yround) > 0
                        X(1) = x;
                        Y(1) = y;
                        x = x + 0.1;
                        y = (x * sind(theta_val)/cosd(theta_val) + rho_val/cosd(theta_val));
                        yround = round(y);
                        while x <= size(orig_img,1) && yround > 0 && yround < size(orig_img,2)
                            if img(round(x), yround) <= 0
                                break;
                            else                             
                              x = x + 0.1;
                              y = (x * sind(theta_val)/cosd(theta_val) + rho_val/cosd(theta_val));
                              yround = round(y);
                            end
                        end
                        X(2) = x;
                        Y(2) = y;
                        line(Y,X, 'LineWidth',0.7, 'Color', 'red');
                    end
                    x = x + 0.1;
                end
            end
        end
    end     
    cropped_line_img = saveAnnotatedImg(fh);
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