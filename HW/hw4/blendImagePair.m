function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)
out_img = [];  
if strcmp(mode, 'overlay')  
    out_img = wrapped_imgs;
    maskd = logical(maskd);
    maskd = ~maskd;
    out_img = double(out_img) .* cat(3, maskd, maskd, maskd) + double(wrapped_imgd);
    out_img = uint8(out_img);
end
if strcmp(mode, 'blend') 
    masks = masks ./ max(masks(:));
    maskd = maskd ./ max(maskd(:));
    wrapped_d = bwdist(1-maskd);  
    wrapped_s = bwdist(1-masks);
    sum = wrapped_s + wrapped_d;
    imgs = [];
    imgd = [];
    for i = 1:3
        imgs(:, :, i) = rdivide(double(wrapped_imgs(:, :, i)).*wrapped_s, sum);
        imgd(:, :, i) = rdivide(double(wrapped_imgd(:, :, i)).*wrapped_d, sum);
    end
    out_img = imgs + imgd;
    if length(find(round(out_img)>1))~=0
        out_img = uint8(out_img);   
    end
end