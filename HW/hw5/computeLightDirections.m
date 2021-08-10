function light_dirs_5x3 = computeLightDirections(center, radius, img_cell)
light_dirs_5x3 = zeros(length(img_cell), 3);

for i = 1:length(img_cell)
    img = img_cell{i};
    IMax = max(img(:));
    [r, c] = find(img == IMax);
    find_center_x = mean(c);
    find_center_y = mean(r);
    x = find_center_x - center(1);
    y = find_center_y - center(2);
    z = sqrt(radius^2 - x^2 - y^2);
    N = [x, y, z];
    light_dirs_5x3(i,:) = (N / norm(N))* double(IMax);
    
    %fh1 = figure;
    %imshow(img);
    %hold on;
    
end
