function stitched_img = stitchImg(varargin)

Nomber_image = length(varargin);
H_arr = zeros(3 , 3 , Nomber_image);
H_arr(: , : , 1) = eye(3);
pts = [];
ransac_n = 300;
ransac_eps = 1;

for i = 2 : Nomber_image
    img_i = varargin{i};
    [xs, xd] = genSIFTMatches(img_i, varargin{1});
    imgi_pts = [1, 1 ; size(img_i , 2), 1 ; size(img_i , 2), size(img_i , 1) ; 1, size(img_i , 1)];
    [~, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);
    H_arr(: , : , i) = H_3x3;
    imgi_pts_conv = applyHomography(H_arr(: , : , i) , imgi_pts);
    pts = [pts ; imgi_pts_conv];
end
 
min_x = min(pts(:,1));
max_x = max(pts(:,1));
min_y = min(pts(:,2));
max_y = max(pts(:,2));
reference = zeros(floor(max_y - min_y) + 1, floor(max_x - min_x) + 1, 3);
dest_size = [size(reference, 2), size(reference, 1)];

results = cell(1 , Nomber_image);
masks_i = cell(1 , Nomber_image);
x = 1 - min_x; 
y = 1 - min_y;
matrix = [1 0 x ; 0 1 y ; 0 0 1];

for i = 1 : Nomber_image
    img_i = varargin{i};
    [maskl, dest_imgl] = backwardWarpImg(img_i, inv(matrix * H_arr(: , : , i)), dest_size);
    masks_i{i} = ~maskl;
    results{i} = reference .* cat(3, masks_i{i}, masks_i{i}, masks_i{i}) + dest_imgl;
end

stitched_img = im2uint8(results{1});
mask_i = (~masks_i{1}) .* 255;
for i = 2: Nomber_image
    results{i} = im2uint8(results{i});
    maski = (~masks_i{i}) .* 255;
    stitched_img = blendImagePair(stitched_img, mask_i, results{i}, maski, 'blend');
    % use blendImagePair function to connect output image and new image
    mask_i = (logical(mask_i) | (~masks_i{i})) .* 255;
end
