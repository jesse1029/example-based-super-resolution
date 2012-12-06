%returns intermediate steps
function [subsampled interpolatedBicubic lowResImage] = prepareLowRes(input)

%simple lowpass/blur filter, all 1s/(size*size), keep size at 3
filterSize = 3;
blurFilter = ones(filterSize,filterSize) * 1/(filterSize*filterSize);
blurredImage = im2double(imfilter(input, blurFilter));

%subsample and interpolate
subsampled = blurredImage(1:2:end,1:2:end,:);
interpolatedBicubic = imresize(subsampled, 2.0, 'bicubic');

%simple high pass filter, all pass - low pass
highPassFilter = [0 0 0; 0 1 0; 0 0 0] - blurFilter;
filteredImage = imfilter(interpolatedBicubic, highPassFilter);

lowResImage = filteredImage;
end