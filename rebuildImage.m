%function output = rebuildImage(kdTree, key2d, subSampledInput, lowResImage, highResImage, keys, values, lowResPatches, highResPatches, originalInput)
function [subsampled interpolated superResImage differenceInterpolated differenceSuperres originalHiRes] = rebuildImage(kdTree, subSampledInput, values, originalInput, alpha)


backImage = im2double(imresize(subSampledInput, 2.0, 'bicubic'));
interpolatedSubSampledInput = backImage;
[r c d] = size(backImage);

filterSize = 3;
blurFilter = ones(filterSize,filterSize) * 1/(filterSize*filterSize);
highPassFilter = [0 0 0; 0 1 0; 0 0 0] - blurFilter;
filteredImage = imfilter(backImage, highPassFilter);

diff2 = backImage - filteredImage;
backImage = filteredImage;
%diff2 = backImage - lowResImage; 




diff1 = zeros(r,c,d);



endR = r-6;
endC = c-6;

%while (i + 6 < r) 
for i = 1:4:endR
    percentage = i/endR*100
    for j = 1:4:endC

      %have i and j
      %get backimage patch
      patch49 = backImage(i:i+6, j:j+6, :);
      
      patch25 = diff1((i+1):(i+5), (j+1):(j+5), :);
      
     

      patch58 = zeros(58,3);
      for k = 1:3
          diff9 = [];
          diff9 = [patch25(1,:,k) patch25(2:end,1,k)'];
          diff9 = diff9*alpha;
          patch58(:,k) = [reshape(patch49(:,:,k), 1, []) diff9];
      end
      
      patch58(:,:,1);
      
      patch58 = reshape(patch58, 1, 174);
      
      scale = getContrastNormalizeScale(patch58);
      patch58 = patch58 / scale;

      %keyDiff1 = lookup(patch58, keys, values);
      %keyDiff2 = accessPatch(highResPatches, i+1, j+1);
      index = knnsearch(kdTree, patch58);
      keyDiff1(:,:,:) = values(index,:,:,:);

      
      diff1((i+1):(i+5), (j+1):(j+5), :) = keyDiff1*scale;
      
    end
    toc;
end

output = diff1+backImage+diff2;

% subplot(1, 3, 1)
% imshow(interpolatedSubSampledInput);
% 
% subplot(1, 3, 2)
% imshow(output);
% 
% subplot(1, 3, 3)
% imshow(originalInput);

superResImage = output;

exists = exist('output-images', 'dir');
if (exists == 7) 
rmdir('output-images');
end
mkdir('output-images');

imwrite(subSampledInput, 'output-images/subsampled.jpg');
imwrite(interpolatedSubSampledInput, 'output-images/interpolated.jpg');
imwrite(superResImage, 'output-images/superRes.jpg');
imwrite(originalInput, 'output-images/original.jpg');

subsampled = subSampledInput;
interpolated = interpolatedSubSampledInput;
originalHiRes = originalInput;

%Get difference between superResImage and originalHiRes
differenceInterpolated = obtainDifference(originalInput, interpolatedSubSampledInput);
differenceSuperres = obtainDifference(originalInput, superResImage);

imwrite(differenceInterpolated, 'output-images/difference-interpolated.jpg');
imwrite(differenceSuperres, 'output-images/difference-superres.jpg');

%imshow(im2double(uint8(difference)));
% asdf = highResImage - diff;
% sum(asdf(:))

% temp = im2double(originalInput) - output;
% finalDifference = sum(temp(:))
end