function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
A = zeros(size(x1, 1), 9);
for i = 1:size(x1, 1)
    A(2*i - 1, :) = [-x2(i, 1), -x2(i, 2), -1, 0, 0, 0, x2(i, 1) * x1(i, 1), x2(i, 2) * x1(i, 1), x1(i, 1)];
    A(2*i, :) = [0, 0, 0, -x2(i, 1), -x2(i, 2), -1, x2(i, 1) * x1(i, 2), x2(i, 2) * x1(i, 2), x1(i, 2)];
end
[U,~,~] = svd(A'*A);
H2to1 = reshape(U(:,end),[3 3])';
end