function [center, radius] = findSphere(img)
I = im2bw(img, 0.000001);
props = regionprops(I, 'Area', 'Centroid');
center = props.Centroid;
radius = sqrt(props.Area / pi);