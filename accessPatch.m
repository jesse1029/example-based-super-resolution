%simple array indexing for more readable code
function patch = accessPatch(patches, i, j) 

patch(:,:,:) = patches(i,j,:,:,:);

end