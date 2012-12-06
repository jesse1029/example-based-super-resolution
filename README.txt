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