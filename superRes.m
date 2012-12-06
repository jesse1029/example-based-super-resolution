function [subsampled interpolated superResImage differenceInterp differenceSuperRes originaHiRes] = superResify(fileName, trueHighResImageName, alpha, bucketSize)

display('Loading training data');
tic;
load(fileName, 'keys', 'values');
toc;
display('Done loading training data');

display('Building kd tree ');
tic;
kdTree = KDTreeSearcher(keys, 'BucketSize', bucketSize);
toc;
display('Done building kd tree');

%convert original image to double version
doubleHighResImage = im2double(imread(trueHighResImageName));

%low frequency and subsampled version of original image to use
%for the actually super resolution and to compare results
subsampledInput = blurSubsample(doubleHighResImage);

display('Rebuilding image');
tic;
[subsampled interpolated superResImage differenceInterp differenceSuperRes originaHiRes] = rebuildImage(kdTree, subsampledInput, values, doubleHighResImage, alpha);
toc;
display('Done rebuilding image');

end