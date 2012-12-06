%blur image and then subsample
function [output] = blurSubsample(input)
%simple average filter (low pass filter)
filterSize = 3;
blurFilter = ones(filterSize,filterSize) * 1/(filterSize*filterSize);
blurredImage = im2double(imfilter(input, blurFilter));

%scale output in half by sampling every other value
output = blurredImage(1:2:end,1:2:end,:);
end

