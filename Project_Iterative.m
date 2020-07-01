clc
clear all
close all


P1 = imread('Source Image\P1_rgb.jpg');
a1 = 14;
b1 = 0.5;
c1 = 2.2;
pid = im2double(P1);
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
x = imread('Source Image\P1.tif');
NIR(:, :, 1) = x(:, :, 4); 
pidd = im2double(uint8(NIR));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);
%figure, imshow(Is);
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);
%figure, imshow(Msi);
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
A1 = BW2;
%figure, imshow(A1);
[FP1,maskedImage] = segmentation_1(P1);
%figure, imshow(A1), colormap(jet);
%figure, imshow(FP1);
lambda = 173.2 - 70;
info = imfinfo('Source Image\P1_rgb.jpg');
w = info.Width;  
h = info.Height;
go = true;
hopt = 100000;
prevJ1 = 0
while go
    L = hopt / (tan(16.3 * pi / 180) * w * h);
    SE = strel('line', L,lambda);
    Mbc = 1 - FP1;
    %figure, imshow(Mbc);
    o = ones(3);
    Mbp = imdilate(Mbc, o);
    %figure, imshow(Mbp);
    Mbp = (double(Mbp) - double(FP1) == 0);
    %figure, imshow(Mbp);
    Nse = getnhood(SE);
    Ssimmax = imdilate(Mbp, getnhood(SE));
    Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
    %figure, imshow(Ssimmax);
    %figure, imshow(BW2);
    Sar = bitand(Ssimmax, A1);
    %figure, imshow(Sar);
    %ans1 = cat(8, P1, Is, Msi, BW2, maskedImage, FP1, Mbp, Sar);
    J1 = jaccard(Sar, A1)
    if ((J1 - prevJ1) < 0)
        go = false;
    end
    prevJ1 = J1;
    hopt = hopt + 10
end
subplot(5,8,1), imshow(P1), title('RGB Image (P#)');
subplot(5,8,2), imshow(Is), title('Shadow Darkened');
subplot(5,8,3), imshow(Msi), title('Shadow Mask(unfiltered)');
subplot(5,8,4),  imshow(BW2), title('Shadow Mask(Filtered)');
subplot(5,8,5),  imshow(maskedImage), title('Building Mask');
subplot(5,8,6),  imshow(FP1), title('Building Footprint');
subplot(5,8,7),  imshow(Mbp), title('Buidling Perimeter');
J1 = jaccard(Sar, A1)
ne = imfuse(Sar, FP1);
ne = imfuse(ne, P1);
subplot(5,8,8),  imshow(ne), title('Building with shadow');



P2 = imread('Source Image\P2_rgb.jpg');
a1 = 14;
b1 = 0.5;
c1 = 2.2;
pid = im2double(P2);
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
x = imread('Source Image\P2.tif');
NIR2(:, :, 1) = x(:, :, 4); 
pidd = im2double(uint8(NIR2));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);
%figure, imshow(Is);
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);
%figure, imshow(Msi);
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
A1 = BW2;
%figure, imshow(A1);
[FP1,maskedImage] = segmentation_2(P2);
%figure, imshow(A1), colormap(jet);
%figure, imshow(FP1);
lambda = 173.2 - 70;
info = imfinfo('Source Image\P2_rgb.jpg');
w = info.Width;  
h = info.Height; 
go = true;
hopt = 100000;
prevJ1 = 0
while go
    L = hopt / (tan(16.3 * pi / 180) * w * h);
    SE = strel('line', L,lambda);
    Mbc = 1 - FP1;
    %figure, imshow(Mbc);
    o = ones(3);
    Mbp = imdilate(Mbc, o);
    %figure, imshow(Mbp);
    Mbp = (double(Mbp) - double(FP1) == 0);
    %figure, imshow(Mbp);
    Nse = getnhood(SE);
    Ssimmax = imdilate(Mbp, getnhood(SE));
    Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
    %figure, imshow(Ssimmax);
    %figure, imshow(BW2);
    Sar = bitand(Ssimmax, A1);
    J1 = jaccard(Sar, A1)
    if ((J1 - prevJ1) < 0)
        go = false;
    end
    prevJ1 = J1;
    hopt = hopt + 10
end
%figure, imshow(Sar);
%ans1 = cat(8, P1, Is, Msi, BW2, maskedImage, FP1, Mbp, Sar);
subplot(5,8,9), imshow(P2);
subplot(5,8,10), imshow(Is);
subplot(5,8,11), imshow(Msi);
subplot(5,8,12),  imshow(BW2);
subplot(5,8,13),  imshow(maskedImage);
subplot(5,8,14),  imshow(FP1);
subplot(5,8,15),  imshow(Mbp);
ne = imfuse(Sar, FP1);
ne = imfuse(ne, P2);
subplot(5,8,16),  imshow(ne);
J2 = jaccard(Sar, A1)


P3 = imread('Source Image\P3_rgb.jpg');
a1 = 14;
b1 = 0.5;
c1 = 2.2;
pid = im2double(P3);
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
x = imread('Source Image\P3.tif');
NIR6(:, :, 1) = x(:, :, 4); 
pidd = im2double(uint8(NIR6));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);
%figure, imshow(Is);
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);
%figure, imshow(Msi);
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
A1 = BW2;
%figure, imshow(A1);
[FP1,maskedImage] = segmentation_3(P3);
%figure, imshow(A1), colormap(jet);
%figure, imshow(maskedImage);
lambda = 173.2 - 70;
info = imfinfo('Source Image\P3_rgb.jpg');
w = info.Width; 
h = info.Height;
go = true;
hopt = 100000;
prevJ1 = 0
while go
    L = hopt / (tan(16.3 * pi / 180) * w * h);
    SE = strel('line', L,lambda);
    Mbc = 1 - FP1;
    %figure, imshow(Mbc);
    o = ones(3);
    Mbp = imdilate(Mbc, o);
    %figure, imshow(Mbp);
    Mbp = (double(Mbp) - double(FP1) == 0);
    %figure, imshow(Mbp);
    Nse = getnhood(SE);
    Ssimmax = imdilate(Mbp, getnhood(SE));
    Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
    %figure, imshow(Ssimmax);
    %figure, imshow(A1);
    Sar = bitand(Ssimmax, A1);
    J1 = jaccard(Sar, A1)
    if (J1 - prevJ1 < 0)
        go = false;
    end
    prevJ1 = J1;
    hopt = hopt + 10
end
%figure, imshow(Sar);
%ans1 = cat(8, P1, Is, Msi, BW2, maskedImage, FP1, Mbp, Sar);
subplot(5,8,33), imshow(P3);
subplot(5,8,34), imshow(Is);
subplot(5,8,35), imshow(Msi);
subplot(5,8,36),  imshow(BW2);
subplot(5,8,37),  imshow(maskedImage);
subplot(5,8,38),  imshow(FP1);
subplot(5,8,39),  imshow(Mbp);
J3 = jaccard(Sar, A1)
ne = imfuse(Sar, FP1);
ne = imfuse(ne, P3);
subplot(5,8,40),  imshow(ne);


P4 = imread('Source Image\P4_rgb.jpg');
a1 = 14;
b1 = 0.5;
c1 = 2.2;
pid = im2double(P4);
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
x = imread('Source Image\P4.tif');
NIR4(:, :, 1) = x(:, :, 4); 
pidd = im2double(uint8(NIR4));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);
%figure, imshow(Is);
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);
%figure, imshow(Msi);
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
A1 = BW2;
%figure, imshow(A1);
[FP1,maskedImage] = segmentation_4(P4);
%figure, imshow(A1), colormap(jet);
%figure, imshow(maskedImage);
lambda = 173.2 - 70;
info = imfinfo('Source Image\P4_rgb.jpg');
w = info.Width;  
h = info.Height;
go = true;
hopt = 100000;
prevJ1 = 0
while go
    L = hopt / (tan(16.3 * pi / 180) * w * h);
    SE = strel('line', L,lambda);
    Mbc = 1 - FP1;
    %figure, imshow(Mbc);
    o = ones(3);
    Mbp = imdilate(Mbc, o);
    %figure, imshow(Mbp);
    Mbp = (double(Mbp) - double(FP1) == 0);
    %figure, imshow(Mbp);
    Nse = getnhood(SE);
    Ssimmax = imdilate(Mbp, getnhood(SE));
    Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
    %figure, imshow(Ssimmax);
    %figure, imshow(A1);
    Sar = bitand(Ssimmax, A1);
    J1 = jaccard(Sar, A1)
    if (J1 - prevJ1 < 0)
        go = false;
    end
    prevJ1 = J1;
    hopt = hopt + 10
end
%figure, imshow(Sar);
%ans1 = cat(8, P1, Is, Msi, BW2, maskedImage, FP1, Mbp, Sar);
subplot(5,8,17), imshow(P4);
subplot(5,8,18), imshow(Is);
subplot(5,8,19), imshow(Msi);
subplot(5,8,20),  imshow(BW2);
subplot(5,8,21),  imshow(maskedImage);
subplot(5,8,22),  imshow(FP1);
subplot(5,8,23),  imshow(Mbp);
%subplot(5,8,24),  imshow(Sar);
J4 = jaccard(Sar, A1)
ne = imfuse(Sar, FP1);
ne = imfuse(ne, P4);
subplot(5,8,24),  imshow(ne);


P5 = imread('Source Image\P5_rgb.jpg');
a1 = 14;
b1 = 0.5;
c1 = 2.2;
pid = im2double(P5);
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
x = imread('Source Image\P5.tif');
NIR5(:, :, 1) = x(:, :, 4); 
pidd = im2double(uint8(NIR5));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);
%figure, imshow(Is);
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);
%figure, imshow(Msi);
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
A1 = BW2;
%figure, imshow(A1);
[FP1,maskedImage] = segmentation_5(P5);
%figure, imshow(A1), colormap(jet);
%figure, imshow(maskedImage);
lambda = 173.2 - 70;
info = imfinfo('Source Image\P5_rgb.jpg');
w = info.Width;  
h = info.Height; 
go = true;
hopt = 100000;
prevJ1 = 0
while go
    L = hopt / (tan(16.3 * pi / 180) * w * h);
    SE = strel('line', L,lambda);
    Mbc = 1 - FP1;
    %figure, imshow(Mbc);
    o = ones(3);
    Mbp = imdilate(Mbc, o);
    %figure, imshow(Mbp);
    Mbp = (double(Mbp) - double(FP1) == 0);
    %figure, imshow(Mbp);
    Nse = getnhood(SE);
    Ssimmax = imdilate(Mbp, getnhood(SE));
    Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
    %figure, imshow(Ssimmax);
    %figure, imshow(A1);
    Sar = bitand(Ssimmax, A1);
    J1 = jaccard(Sar, A1)
    if (J1 - prevJ1 < 0)
        go = false;
    end
    prevJ1 = J1;
    hopt = hopt + 10
end
%figure, imshow(Sar);
%ans1 = cat(8, P1, Is, Msi, BW2, maskedImage, FP1, Mbp, Sar);
subplot(5,8,25), imshow(P5);
subplot(5,8,26), imshow(Is);
subplot(5,8,27), imshow(Msi);
subplot(5,8,28),  imshow(BW2);
subplot(5,8,29),  imshow(maskedImage);
subplot(5,8,30),  imshow(FP1);
subplot(5,8,31),  imshow(Mbp);
%subplot(5,8,32),  imshow(Sar);
J5 = jaccard(Sar, A1)
ne = imfuse(Sar, FP1);
ne = imfuse(ne, P5);
subplot(5,8,32),  imshow(ne);