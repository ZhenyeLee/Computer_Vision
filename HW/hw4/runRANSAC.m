function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)
maxcount = 0;
for i = 1 : ransac_n
    rand_ind = randperm(size(Xs , 1) , 4);
    src = Xs(rand_ind , :);
    dest = Xd(rand_ind , :);
    H1 = computeHomography(src , dest);
    X1 = applyHomography(H1 , Xs);
    dist = (Xd(:,1) - X1(:,1)).^2 + (Xd(:,2) - X1(:,2)).^2;
    index = find(dist < eps * eps);
    if (size(index , 1) > maxcount)
        maxcount = size(index , 1);
        inliers_id = index;
        H = H1;
    end
end