left = imread('../data/pano_left.jpg');
right = imread('../data/pano_right.jpg');

[locs1, locs2] = matchPics(left, right);
orig = [564 930 536 826 1148 895 651 719 1377 1201;
        571 113 164 802 911 239 300 1026 437 521];

% computeH
q = computeH(locs1, locs2) \ [orig; ones(1, size(orig,2))];
trans = [q(1,:)./q(3,:); q(2,:)./q(3,:)];
showMatchedFeatures(left, right, orig', trans', 'montage');
title('Homography transformation');

%computeH_norm
q = computeH_norm(locs1, locs2) \ [orig; ones(1, size(orig,2))];
trans = [q(1,:)./q(3,:); q(2,:)./q(3,:)];
figure;
showMatchedFeatures(left, right, orig', trans', 'montage');
title('Normalised Homography transformation');

%computeH_ransac
[H2to1, inliers, pairs] = computeH_ransac(locs1, locs2);
set1 = zeros(4, 2);
set2 = zeros(4, 2);
for i = 1:4
    set1(i, :) = locs1(pairs(i), :);
    set2(i, :) = locs2(pairs(i), :);
end
x1H = locs1(inliers == 1, :);
q = H2to1 * [x1H'; ones(1, size(x1H',2))];
trans = [q(1,:)./q(3,:); q(2,:)./q(3,:)];

figure;
showMatchedFeatures(left, right, set1, set2, 'montage');
title('RANSAC 4 point-pairs');

figure;
showMatchedFeatures(left, right, x1H, trans', 'montage');
title('RANSAC inlier matches transformation');