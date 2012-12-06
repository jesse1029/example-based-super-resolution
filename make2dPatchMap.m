%create an indexed array of patches based on input image
function [patches numRows numCols] = make2dPatchMap(input, patchSize)

[r c d] = size(input);

clippedRows = r-patchSize+1;
clippedCols = c-patchSize+1;

patches = (zeros(clippedRows, clippedCols, patchSize, patchSize, 3));

parfor i = 1:clippedRows
    for j = 1:clippedCols
        
        %offset by -1, since k and m start from 1
        xOffset = i-1;
        yOffset = j-1;
        
        for k = 1:patchSize
            for m = 1:patchSize
                patches(i,j,k,m,:) = input(k+xOffset, m+yOffset,:);
            end
        end
        
    end
end

numRows = clippedRows;
numCols = clippedCols;

end