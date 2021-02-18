function [db, out_img] = compute2DProperties(orig_img, labeled_img)
num_obj = max(labeled_img(:));
db = zeros(6, num_obj);
fh1 = figure();
imshow(orig_img);
hold on
for i=1:num_obj
    f=(labeled_img==i);
    db(1,i) = i;
    Area=sum(sum(f));
    [R,C]=meshgrid(1:size(orig_img,2),1:size(orig_img,1));
    
    %find center
    row = sum(sum(R.*f))/Area;
    column = sum(sum(C.*f))/Area; 
    db(2,i) = row;
    db(3,i) = column;
    
    %shifting the coordinate 
    R = R - row;
    C = C - column;
    %compute a, b, c
    a = sum(sum(R.^2.*f));
    b = 2 * sum(sum(R .* C .*f));
    c = sum(sum(C.^2.*f));
    
    %find the oritation
    theta_1 = atan2(b, a-c)/2;
    theta_2 = theta_1 + pi/2;
    % find the minimum moment of inertia and roundness
    E_min = a * sin(theta_1).^2 - b*sin(theta_1)*cos(theta_1) + c * cos(theta_1).^2;
    E_max = a * sin(theta_2).^2 - b*sin(theta_2)*cos(theta_2) + c * cos(theta_2).^2; 
    roundness = E_min/E_max;

    
    db(4,i) = E_min;
    db(5,i) = theta_1;
    db(6,i) = roundness;
    %Ploting the centroid of objects
    plot(row, column,'ws', 'MarkerFaceColor', [1 0 0]);

    % Plotting the orientation
    x_delta = (50*cos(theta_1));
    y_delta = (50*sin(theta_1));
    x1 = row+x_delta;
    x2 = row-x_delta;
    y1 = column+y_delta;
    y2 = column-y_delta;
    plot([x1 x2],[y1 y2], "Linewidth",1.5);
end
hold on
out_img = saveAnnotatedImg(fh1);
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