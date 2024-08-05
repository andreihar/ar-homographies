function [locs1, locs2] = matchPics(I1, I2)
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
im1 = im2gray(I1);
im2 = im2gray(I2);
%% Detect features in both images
d1 = detectSURFFeatures(im1); %detectFASTFeatures(im1);
d2 = detectSURFFeatures(im2); %detectFASTFeatures(im2);
%% Obtain descriptors for the computed feature locations
[desc1, locs1] = extractFeatures(im1, d1.Location, 'Method', 'SURF'); %computeBrief(im1, d1.Location); 
[desc2, locs2] = extractFeatures(im2, d2.Location, 'Method', 'SURF'); %computeBrief(im2, d2.Location); 
%% Match features using the descriptors
pairs = matchFeatures(desc1, desc2);%, 'MatchThreshold', 10.0, 'MaxRatio', 0.688);
locs1 = locs1(pairs(:,1),:).Location;
locs2 = locs2(pairs(:,2),:).Location;
%showMatchedFeatures(I1, I2, locs1, locs2, 'montage');
end

