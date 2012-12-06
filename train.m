function [keys values] = train(inputImage, alpha)

%read in input image
inputImage = im2double(imread(inputImage));

%perform preprocessing steps, blur/downsample/interpolate/highpass
[subsampled interpolatedSubsampled lowResImage] = prepareLowRes(inputImage);
highResImage = im2double(inputImage) - im2double(interpolatedSubsampled);

%make lowResPatches
[lowResPatches lowResRows, lowResCols] = make2dPatchMap(lowResImage, 7);
%DO NOT USE HIGH RES DIMENSIONS
[highResPatches highResRows, highResCols] = make2dPatchMap(highResImage, 5);
   
%create key/values based on patches
[keys values] = createVectors(alpha, lowResPatches, highResPatches, lowResRows, lowResCols);


end