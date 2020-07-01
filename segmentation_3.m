function [BW,maskedImage] = segmentation_3(RGB)

X = rgb2lab(RGB);


BW = false(size(X,1),size(X,2));



xPos = [80.2972 46.8529 125.0535 156.5305];
yPos = [207.8053 265.8410 310.5973 251.0862];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;



xPos = [126.5290 82.7563 239.6493 284.4056];
yPos = [117.8009 192.5587 280.5958 205.3462];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;


maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
end

