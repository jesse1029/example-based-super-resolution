====================NOTES======================
The example images included in this project are of sizes between 40-60 pixels in
each dimension so it is not the best display of the effects of this algorithm 
(though you can still make out that high frequency details are being added to the
image, and it will appear less blurry).

This algorithm is very costly, since it will essentially generate two sets of patches
for data and these are sets are roughly 25x and 49x the size of the image (25 pixel
and 49 pixel patch generated for each original pixel). Furthermore, it will build a
K-D Tree out of these patches, and perform a search through a combination of those sets
for 1/16 of the pixels in the final output image.

It takes about .5-1.5 minutes to generate the training set for 5 images between 100-200
pixels in each dimension, and about 3-4 minutes to perform the super resolution for
an image between 100-200 pixels in each dimension (the searching for the nearest neighbor
to find the best match is the largest bottleneck)

==================GUI USAGE====================
To run the GUI, in Matlab, open the SuperResolution.m file, and just hit run
Select the image to digitally enhance with superresolution.
Select the training images.
Generate the training set.
Click to super-resify.

=========Matlab Command Window Usage===========

%specify alpha, name for training data file, and input image files
alpha = .5444
saveFileName = 'name.mat'
inputImageFileNames = {'input1.png' 'input2.png' 'input3.png'}

%generate traning set, will print statements indicating progress
buildTrainingSet(inputImageFileNames, saveFileName, alpha);
 
%will perform the actual super resolution, stores results in an output directory
%that is created by MATLAB (output-images)
superRes(saveFileName, 'imageToSuperRes.png', alpha);

====================================
[done] For Faces:
-------------
 
inputImageFileNames = {'face_bill.png' 'face_generic1.png' 'face_generic2.png' 'face_jobs.png'};
 
buildTrainingSet(inputImageFileNames, saveFileName, alpha);
 
superRes(saveFileName, 'face_ObamaSuperRes.png', alpha);
 
====================================
[done] For Cartoon:
-------------
 
inputImageFileNames = {'cartoon_avatar1.png' 'cartoon_familyguy2.png' 'cartoon_simpsons1.png' 'cartoon_southpark1.png'};
 
buildTrainingSet(inputImageFileNames, saveFileName, alpha);
 
superRes(saveFileName, 'cartoon_SuperResCartoon.png', alpha);
 
====================================
[done] For flowers:
-------------
 
inputImageFileNames = { 'flowers1.png' 'flowers2.png' 'flowers3.png' 'flowers4.png' 'flowers5.png' };
 
buildTrainingSet(inputImageFileNames, saveFileName, alpha);
 
superRes(saveFileName, 'flowersSuperRes.png', alpha);
 
====================================
Bad data:
-------------
inputImageFileNames = { 'magnacarta.png' };
 
buildTrainingSet(inputImageFileNames, saveFileName, alpha);
 
superRes(saveFileName, 'obama.png', alpha);