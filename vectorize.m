function output = vectorize(alpha, lowResPatches, highResPatches, i, j);

lowResPatch = accessPatch(lowResPatches, i,j);  %7x7x3
highResPatch = accessPatch(highResPatches, i+1,j+1);

output = zeros(1,58,3);

for k = 1:3
    highResOutput = [];
    highResOutput = [highResPatch(1,:,k) highResPatch(2:end,1,k)'];
    highResOutput = highResOutput * alpha;
    output(:,:,k) = [reshape(lowResPatch(:,:,k), 1, []) highResOutput];
end

output = reshape(output, 1, 174);

end

