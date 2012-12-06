function buildTrainingSet(inputImageFileNames, saveFileName, alpha)

%c contains number of input files
[r c] = size(inputImageFileNames);

%training set is a huge set of key-value pairs
keys = [];
values = [];

%tic and toc are for time profiling in matlab
overallTicId = tic;
for i = 1:c    
    display(['Generating training set from image:  ' inputImageFileNames{i}]);

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