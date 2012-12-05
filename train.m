function [keys values] = train(inputImage, alpha)

%enable parallel processing
%matlabpool call this in command window so instance is true always

%read in input image, DO NOT MODIFY INPUT
inputImage = im2double(imread(inputImage));

%perform preprocessing steps, blur/downsample/interpolate/highpass
[subsampled interpolatedSubsampled lowResImage] = lowFilter(inputImage);
highResImage = highFilter(inputImage, interpolatedSubsampled);


% subplot(1,2,1)
% imshow(interpolatedLowRes);
% 
% subplot(1,2,2)
% imshow(highResImage);

%make lowResPatches
[lowResPatches lowResRows, lowResCols] = make2dPatchMap(lowResImage, 7);
%DO NOT USE HIGH RES DIMENSIONS
[highResPatches highResRows, highResCols] = make2dPatchMap(highResImage, 5);
   
[keys values] = createVectors(alpha, lowResPatches, highResPatches, lowResRows, lowResCols);


end