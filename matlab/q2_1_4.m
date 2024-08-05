%Q2.1.4
close all;
clear all;

%cv_cover = imread('../data/cv_cover.jpg');
%cv_desk = imread('../data/cv_desk.png');
cv_cover = imread('../data/pano_left.jpg');
cv_desk = imread('../data/pano_right.jpg');


[locs1, locs2] = matchPics(cv_cover, cv_desk);

figure;
showMatchedFeatures(cv_cover, cv_desk, locs1.Location, locs2.Location, 'montage');
title('Showing all matches');
