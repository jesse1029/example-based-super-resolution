function [subsampled interpolatedSubsampled lowResImage] = lowFilter(input)

%simple average filter, all 1s/(size*size)  KEEP FILTERSIZE AT 3 SINCE
%HIGHPASS FILTER IS HARD CODED
filterSize = 3;
blurFilter = ones(filterSize,filterSize) * 1/(filterSize*filterSize);
blurredImage = im2double(imfilter(input, blurFilter));
%imshow(blurredImage);

%take every 2nd value, hopefully input is even in size, otherwise last
%value clipped
subsampled = blurredImage(1:2:end,1:2:end,:);
%imshow(subsampled);

%http://www.mathworks.com/help/images/ref/imresize.html details for
%interpolatedBilinear = imresize(subSampled, 2.0, 'bilinear');
interpolatedBicubic = imresize(subsampled, 2.0, 'bicubic');
%imshow(interpolatedBicubic);

interpolatedSubsampled = interpolatedBicubic;

%simple high pass filter, all pass - low pass should work
highPassFilter = [0 0 0; 0 1 0; 0 0 0] - blurFilter;
filteredImage = imfilter(interpolatedSubsampled, highPassFilter);

lowResImage = filteredImage;
%imshow(output);
end