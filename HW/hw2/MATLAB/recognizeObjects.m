function output_img = recognizeObjects(orig_img, labeled_img, obj_db)
    num_obj = max(labeled_img(:));
    %Can adjust the threshold
    threshold = 0.2;
    [test_db,test_out] = compute2DProperties(orig_img,labeled_img);
    fh1 = figure();
    imshow(orig_img);
    hold on;
    for i = 1:num_obj
        test_pro = test_db(:,i);
        diff = abs(test_pro(6) - obj_db(6))/(obj_db(6));
        if(diff(1) < 0.1)
            % draw the center and the orientation;
            db = test_db(:,i);
            x_delta = (50*cos(db(5)));
            y_delta = (50*sin(db(5)));
            x1 = db(2)+x_delta;
            x2 = db(2)-x_delta;
            y1 = db(3)+y_delta;
            y2 = db(3)-y_delta;
            row = db(2);
            column = db(3);
            plot(row,column,'ws', 'MarkerFaceColor', [1 0 0]);
            plot([x1 x2],[y1 y2], "Linewidth",1.5);
            hold on;
        end
    end
output_img = saveAnnotatedImg(fh1);
%%  
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