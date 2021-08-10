function mask = computeMask(img_cell)
mask = zeros(size(img_cell{1}));
for i = 1:size(img_cell , 1)
    img = img_cell{i};
    mask(img > 0) = 1;
end