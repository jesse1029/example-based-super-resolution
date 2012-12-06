%creates the actual key and values from the patch information
function [key values] = createVectors(alpha, lowResPatches, highResPatches, numRows, numCols)

%key is a 58 pixel vector (for each color channel). 58 pixels includes all
%49 (7x7) pixels from low res patch, and the 9 pixels from first row and
%column of high res patch (5x5 pixels)

%the value is the whole high res patch

%1 1 1 1 1 1 1      1 1 1 1 1
%1 1 1 1 1 1 1      1 0 0 0 0
%1 1 1 1 1 1 1      1 0 0 0 0
%1 1 1 1 1 1 1      1 0 0 0 0 
%1 1 1 1 1 1 1      1 0 0 0 0
%1 1 1 1 1 1 1
%1 1 1 1 1 1 1


%pixe
key = zeros(numRows*numCols, 174);%174 = 3(rgb) * (7*7(lowrespatch) + 9(highrespatch))
values = zeros(numRows*numCols, 5, 5, 3);

k = 1;
for i = 1:numRows
    for j = 1:numCols
        output = vectorize(alpha, lowResPatches, highResPatches, i,j);
        
        %perform contrast normalization so training set is more
        %general
        scale = getContrastNormalizeScale(output);
        output = output/scale;
        
        
        key(k,:) = output;
        
        values(k,:,:,:) = accessPatch(highResPatches, i+1, j+1)/scale;
        
        k = k + 1;
    end
end


end