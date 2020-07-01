function [BW,maskedImage] = segmentation_1(RGB)
X = rgb2lab(RGB);


BW = false(size(X,1),size(X,2));


xPos = [86.9658 158.3730 199.0713 125.0743];
yPos = [129.4398 94.6612 179.7578 214.5364];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;


maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
end

