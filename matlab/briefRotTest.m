% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
im = imread('../data/cv_cover.jpg'); %matchPics converts to grayscale
%% Compute the features and descriptors
count = zeros(1, 37);
angle = zeros(1, 37);
for i = 0:36
    %% Rotate image
    imr = imrotate(im, 10*i);
    %% Compute features and descriptors
    [locs1, locs2] = matchPics(im, imr);
    %% Match features
    if i == 0 || i == 4 || i == 9
        figure;
        showMatchedFeatures(im, imr, locs1, locs2, 'montage');
    end
    %% Update histogram
    angle(i+1) = i*10;
    count(i+1) = size(locs1, 1);
end

%% Display histogram
figure;
plot(angle, count);
title('SUFR');
xlabel('Angle');
ylabel('Number of Matches');