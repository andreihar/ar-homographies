function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2) %, pairs
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3
bestH2to1 = zeros(3, 3);
best = [];
%pairs = [];
maxCount = 0;

N = 100;
pointPair = 4;

if size(locs1, 1) < pointPair
    inliers = [];
    return;
end

for iter = 1:N
    inliers = zeros(1, size(locs1, 1));
    set1 = zeros(pointPair, 2);
    set2 = zeros(pointPair, 2);
    randomNums = randperm(size(locs1, 1), pointPair);
    for i = 1:pointPair
        set1(i, :) = locs1(randomNums(i), :);
        set2(i, :) = locs2(randomNums(i), :);
    end
    H2to1 = computeH(set1, set2);
    x2H = H2to1 * [locs2 ones(size(locs2, 1), 1)]';
    numel = (x2H ./ x2H(3, :)) - [locs1 ones(size(locs1, 1), 1)]';
    numel = sqrt(numel(1, :).^2 + numel(2, :).^2);
    for i = 1:size(locs1, 1)
        if numel(i) < 10
            inliers(i) = 1;
        end
    end
    suml = sum(numel(:) < 10);
    if suml > maxCount
        best = inliers;
        %pairs = randomNums;
        maxCount = suml;
    end
end
inliers = best;
x2H = locs2(inliers == 1, :);
x1H = locs1(inliers == 1, :);
bestH2to1 = inv(computeH_norm(x1H, x2H));
end

