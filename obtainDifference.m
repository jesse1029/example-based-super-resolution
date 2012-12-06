%obtains the difference between two images, and scales
%it into a 0 to 255 gray level image
function difference = obtainDifference(input1, input2)

[r c d] = size(input1);
difference = zeros(r,c);
for i = 1:r
    for j = 1:c
        rDiff = input1(i,j,1) - input2(i,j,1);
        gDiff = input1(i,j,2) - input2(i,j,2);
        bDiff = input1(i,j,3) - input2(i,j,3);
        
        distance = sqrt(rDiff*rDiff + gDiff*gDiff + bDiff*bDiff);
        difference(i,j) = distance;

    end
end

maxDiff = max(difference(:));
difference = difference / maxDiff;
difference = difference * 255;
difference = uint8(difference);

imshow(difference);

end