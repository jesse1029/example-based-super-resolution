function [subsampled interpolated superResImage difference originaHiRes] = superRes(fileName, trueHighResImageName, alpha, bucketSize)

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

doubleHighResImage = im2double(imread(trueHighResImageName));
subsampledInput = blurSubsample(doubleHighResImage);

display('Rebuilding image');
tic;
[subsampled interpolated superResImage difference originaHiRes] = rebuildImage(kdTree, subsampledInput, values, doubleHighResImage, alpha);
toc;
display('Done rebuilding image');

end