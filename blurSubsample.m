function [ output ] = blurSubsample( input )
filterSize = 3;
blurFilter = ones(filterSize,filterSize) * 1/(filterSize*filterSize);
blurredImage = im2double(imfilter(input, blurFilter));
%imshow(blurredImage);

%take every 2nd value, hopefully input is even in size, otherwise last
%value clipped
output = blurredImage(1:2:end,1:2:end,:);
end

