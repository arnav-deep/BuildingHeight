function [BW,maskedImage] = segmentation_2(RGB)
X = rgb2lab(RGB);


BW = false(size(X,1),size(X,2));



xPos = [57.1100 56.8410 271.9970 263.9287];
yPos = [148.2853 156.6226 118.4324 111.1709];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;

maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
end

