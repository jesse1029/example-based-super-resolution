function buildTrainingSet(inputImageFileNames, saveFileName, alpha)

[r c] = size(inputImageFileNames);

keys = [];
values = [];

overallTicId = tic;
for i = 1:c    
    display(['Generating training set from image:  ' inputImageFileNames{i}]);%'Generating training set from image');%, inputImageFileNames{i});

    tic;
    [tKeys tValues] = train(inputImageFileNames{i}, alpha);
    toc;
    keys = [keys ; tKeys];
    values = [values ; tValues];
end
display('Overall time:');
toc(overallTicId);

display('Saving file');
tic;
save(saveFileName, 'keys', 'values');
toc;
display('Done saving file');