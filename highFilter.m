function output = highFilter(input, lowResImage)
% 
% filterSize = 3;
% blurFilter = ones(filterSize,filterSize) * 1/(filterSize*filterSize);
% highPassFilter = [0 0 0; 0 1 0; 0 0 0] - blurFilter;
% filteredImage = imfilter(input, highPassFilter);

output = im2double(input) - im2double(lowResImage);
%imshow(output)

end