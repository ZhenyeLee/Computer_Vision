function H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2)
A = [];
N = size(src_pts_nx2 , 1);

for i = 1 : N
    A = [A ; src_pts_nx2(i,1) src_pts_nx2(i,2) 1 0 0 0 -dest_pts_nx2(i,1) * src_pts_nx2(i,1) -dest_pts_nx2(i,1) * src_pts_nx2(i,2) -dest_pts_nx2(i,1)];
    A = [A ; 0 0 0 src_pts_nx2(i,1) src_pts_nx2(i,2) 1 -dest_pts_nx2(i,2) * src_pts_nx2(i,1) -dest_pts_nx2(i,2) * src_pts_nx2(i,2) -dest_pts_nx2(i,2)];
end


[V , ~] = eig(A' * A);
H_3x3 = [V(1:3 , 1)' ; V(4:6 , 1)' ; V(7:9 , 1)'];
