%function output = rebuildImage(kdTree, key2d, subSampledInput, lowResImage, highResImage, keys, values, lowResPatches, highResPatches, originalInput)
function [subsampled interpolated superResImage differenceInterpolated differenceSuperres originalHiRes] = rebuildImage(kdTree, subSampledInput, values, originalInput, alpha)

%recreate the low res image that you will be adding the difference to
backImage = im2double(imresize(subSampledInput, 2.0, 'bicubic'));
interpolatedSubSampledInput = backImage;
[r c d] = size(backImage);

%obtain high frequencies from the low res image
filterSize = 3;
blurFilter = ones(filterSize,filterSize) * 1/(filterSize*filterSize);
highPassFilter = [0 0 0; 0 1 0; 0 0 0] - blurFilter;
filteredImage = imfilter(backImage, highPassFilter);

%diff difference between low res and high passed version of the low res image
%it is added back to reconstructed image at the end
diff = backImage - filteredImage;
backImage = filteredImage;

%initialize reconstructed image
reconstructedImage = zeros(r,c,d);

endR = r-6;
endC = c-6;

%while (i + 6 < r) 
for i = 1:4:endR
    %print current percentage done
    percentage = i/endR*100
    for j = 1:4:endC

    %get corresponding low res patch
    patch49 = backImage(i:i+6, j:j+6, :);
    
    %obtain current high res patch being built for extracting
    %9 upper left values
    patch25 = reconstructedImage((i+1):(i+5), (j+1):(j+5), :);
      
     
    %concatenate patch so has 58 elements and becomes key
    patch58 = zeros(58,3);
    for k = 1:3
        patch9 = [];
        patch9 = [patch25(1,:,k) patch25(2:end,1,k)'];
        patch9 = patch9*alpha;
        patch58(:,k) = [reshape(patch49(:,:,k), 1, []) patch9];
    end        
    patch58 = reshape(patch58, 1, 174);
    
    %undo contrast normalize
    scale = getContrastNormalizeScale(patch58);
    patch58 = patch58 / scale;

    %obtain the value
    index = knnsearch(kdTree, patch58);
    value(:,:,:) = values(index,:,:,:);

    %add high res patch to the image being reconstructed
    reconstructedImage((i+1):(i+5), (j+1):(j+5), :) = value*scale;
      
    end
    toc;
end

output = reconstructedImage+backImage+diff;

superResImage = output;

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

end