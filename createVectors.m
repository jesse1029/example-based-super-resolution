%NUM ROWS AND COLS IS FOR 7 X 7
function [key values] = createVectors(alpha, lowResPatches, highResPatches, numRows, numCols)

key = zeros(numRows*numCols, 174);
values = zeros(numRows*numCols, 5, 5, 3);

k = 1;
for i = 1:numRows
    for j = 1:numCols
        output = vectorize(alpha, lowResPatches, highResPatches, i,j);
        
        scale = getContrastNormalizeScale(output);
        output = output/scale;
        
        
        key(k,:) = output;
        
        values(k,:,:,:) = accessPatch(highResPatches, i+1, j+1)/scale;
        
        k = k + 1;
    end
end


end