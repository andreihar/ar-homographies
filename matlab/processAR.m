function result_img = processAR(sourceImg, replacementImg, replacedImg, x, y, shouldCrop)
    cv_img = replacedImg;
    desk_img = sourceImg;
    hp_img = replacementImg;

    if shouldCrop
        cropWidth = min(x, size(replacementImg, 2));
        cropHeight = min(y, size(replacementImg, 1));
        if cropWidth > 0 && cropHeight > 0
            replacementImg = imcrop(replacementImg, centerCropWindow2d(size(replacementImg), [cropHeight, cropWidth]));
        else
            warning('Invalid crop size. Skipping cropping.');
        end
    end

    [locs1, locs2] = matchPics(replacedImg, sourceImg);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    scaledReplacementImg = imresize(replacementImg, [size(replacedImg, 1), size(replacedImg, 2)]);
    result_img = compositeH(inv(bestH2to1), scaledReplacementImg, sourceImg);
end