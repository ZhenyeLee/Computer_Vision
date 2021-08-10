function [normals, albedo_img] = ...
    computeNormals(light_dirs, img_cell, mask)

all_img = zeros(size(mask,1), size(mask,2), size(img_cell, 1));
for i=1:size(img_cell, 1)
    all_img(:,:,i) = img_cell{i};
end

albedo_img = zeros(size(mask,1), size(mask,2));
normals = zeros(size(mask,1), size(mask,2), 3);

[y, x] = find(mask == 1);
for i=1:size(x,1)
    for j=1:size(img_cell, 1)
        I(j,1) = all_img(y(i), x(i), j);
    end
    S = light_dirs;
    N = inv(S' * S) * S' * I;
    normals(y(i),x(i), :) = N / norm(N);
    albedo_img(y(i), x(i)) = norm(N);
end

albmax = max(albedo_img(:));
albedo_img = albedo_img./albmax;

end
 