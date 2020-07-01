% """"""""""""""""""""""""""""""""""""""""""""""""""""
%
%
% A Shadow-Overlapping Algorithm for Estimating 
% Building Heights From VHR Satellite Images.
%
% Image Processing (CS313a)
%
% Manjot Singh - 2017330
% Arnav Deep - 2017316
%
% 
% """"""""""""""""""""""""""""""""""""""""""""""""""""

clc
clear all
close all

% Global Constants for all images.
a1 = 14;
b1 = 0.5;
c1 = 2.2;
phi = 16.3;
O = ones(3);


% """"""""""""""""""""""""""""""""""""""""""""""""""""
% For Image P1
P1 = imread('Source Image\P1_rgb.jpg');
pid = im2double(P1);
%figure(11), imshow(P1);

% Step 1: Obtain Shadow Image
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
tiff_img = imread('Source Image\P1.tif');
NIR1(:, :, 1) = tiff_img(:, :, 4); 
pidd = im2double(uint8(NIR1));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);     % Is is the shadow image
%figure(12), imshow(Is);

% Step 2: Create Initial Shadow Mask
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);    %Msi is shadow Mask
%figure(13), imshow(Msi);

% Step 3: Filtering Msi
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
Ms = BW2;       % Ms is the shadow mask
%figure(14), imshow(Ms);

% Step 4 & 5: Segmenting Image & obtaining Building Mask
[Mb,Mbi] = segmentation_1(P1);
% Mbi is initial building mask
% Mb is binarized building mask
%figure(15), imshow(Mbi);
%figure(16), imshow(Mb);

% Step 6: Obtain Perimeter of Building, Mbp
Mbc = 1 - Mb;
Mba = imdilate(Mbc, O);
Mbp = (double(Mba) - double(Mb) == 0);     %Mbp is perimeter of building
%figure(17), imshow(Mbp);

% Step 7: Create Artificial Shadows of Buildings
lambda = 173.2 - 70;
info = imfinfo('Source Image\P1_rgb.jpg');
w = info.Width;  
h = info.Height; 
L = 7500000 / (tan(phi * pi / 180) * w * h);
SE = strel('line', L, lambda);
Nse = getnhood(SE);
Ssimmax = imdilate(Mbp, getnhood(SE));
Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
Sar = bitand(Ssimmax, Ms);       % Sar is the artifical shadow
ne = imfuse(Sar, Mb);
ne = imfuse(ne, P1);        % ne is the artifical shadow with building mask
%figure(18), imshow(ne);

% Step 8: Calculate Height Using Jaccard Index
J1 = jaccard(Sar, Ms)

% Subplot
subplot(5,8,1), imshow(P1), title('RGB Image (P#)');
subplot(5,8,2), imshow(Is), title('Shadow Darkened');
subplot(5,8,3), imshow(Msi), title('Shadow Mask(unfiltered)');
subplot(5,8,4),  imshow(Ms), title('Shadow Mask(Filtered)');
subplot(5,8,5),  imshow(Mbi), title('Building Mask');
subplot(5,8,6),  imshow(Mb), title('Building Footprint');
subplot(5,8,7),  imshow(Mbp), title('Buidling Perimeter');
subplot(5,8,8),  imshow(ne), title('Building with shadow');

% """"""""""""""""""""""""""""""""""""""""""""""""""""


% """"""""""""""""""""""""""""""""""""""""""""""""""""
% For Image P2
P2 = imread('Source Image\P2_rgb.jpg');
pid = im2double(P2);
%figure(21), imshow(P2);

% Step 1: Obtain Shadow Image
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
tiff_img = imread('Source Image\P2.tif');
NIR2(:, :, 1) = tiff_img(:, :, 4); 
pidd = im2double(uint8(NIR2));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);    % Is is the shadow image
%figure(22), imshow(Is);

% Step 2: Create Initial Shadow Mask
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);    %Msi is shadow Mask
%figure(23), imshow(Msi);

% Step 3: Filtering Msi
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
Ms = BW2;       % Ms is the shadow mask
%figure(24), imshow(Ms);

% Step 4 & 5: Segmenting Image & obtaining Building Mask
[Mb,Mbi] = segmentation_2(P2);
% Mbi is initial building mask
% Mb is binarized building mask
%figure(25), imshow(Mbi);
%figure(26), imshow(Mb);

% Step 6: Obtain Perimeter of Building, Mbp
Mbc = 1 - Mb;
Mba = imdilate(Mbc, O);
Mbp = (double(Mba) - double(Mb) == 0);     %Mbp is perimeter of building
%figure(27), imshow(Mbp);

% Step 7: Create Artificial Shadows of Buildings
lambda = 173.2 - 70;
info = imfinfo('Source Image\P2_rgb.jpg');
w = info.Width;  
h = info.Height; 
L = 6500000 / (tan(phi * pi / 180) * w * h);
SE = strel('line', L, lambda);
Nse = getnhood(SE);
Ssimmax = imdilate(Mbp, getnhood(SE));
Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
Sar = bitand(Ssimmax, Ms);       % Sar is the artifical shadow
ne = imfuse(Sar, Mb);
ne = imfuse(ne, P2);        % ne is the artifical shadow with building mask
%figure(28), imshow(ne);

% Step 8: Calculate Height Using Jaccard Index
J2 = jaccard(Sar, Ms)

% Subplot
subplot(5,8,9), imshow(P2);
subplot(5,8,10), imshow(Is);
subplot(5,8,11), imshow(Msi);
subplot(5,8,12),  imshow(Ms);
subplot(5,8,13),  imshow(Mbi);
subplot(5,8,14),  imshow(Mb);
subplot(5,8,15),  imshow(Mbp);
subplot(5,8,16),  imshow(ne);

% """"""""""""""""""""""""""""""""""""""""""""""""""""


% """"""""""""""""""""""""""""""""""""""""""""""""""""
% For Image P3
P3 = imread('Source Image\P3_rgb.jpg');
pid = im2double(P3);
%figure(31), imshow(P3);

% Step 1: Obtain Shadow Image
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
tiff_img = imread('Source Image\P3.tif');
NIR3(:, :, 1) = tiff_img(:, :, 4); 
pidd = im2double(uint8(NIR3));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);        % Is is the shadow image
%figure(32), imshow(Is);

% Step 2: Create Initial Shadow Mask
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);    %Msi is shadow Mask
%figure(33), imshow(Msi);

% Step 3: Filtering Msi
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
Ms = BW2;       % Ms is the shadow mask
%figure(34), imshow(Ms);

% Step 4 & 5: Segmenting Image & obtaining Building Mask
[Mb,Mbi] = segmentation_3(P3);
% Mbi is initial building mask
% Mb is binarized building mask
%figure(35), imshow(Mbi);
%figure(36), imshow(Mb);

% Step 6: Obtain Perimeter of Building, Mbp
Mbc = 1 - Mb;
Mba = imdilate(Mbc, O);
Mbp = (double(Mba) - double(Mb) == 0);     %Mbp is perimeter of building
%figure(37), imshow(Mbp);

% Step 7: Create Artificial Shadows of Buildings
lambda = 173.2 - 70;
info = imfinfo('Source Image\P3_rgb.jpg');
w = info.Width;  
h = info.Height; 
L = 8100000 / (tan(phi * pi / 180) * w * h);
SE = strel('line', L, lambda);
Nse = getnhood(SE);
Ssimmax = imdilate(Mbp, getnhood(SE));
Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
Sar = bitand(Ssimmax, Ms);       % Sar is the artifical shadow
ne = imfuse(Sar, Mb);
ne = imfuse(ne, P3);        % ne is the artifical shadow with building mask
%figure(38), imshow(ne);

% Step 8: Calculate Height Using Jaccard Index
J3 = jaccard(Sar, Ms)

% Subplot
subplot(5,8,17), imshow(P3);
subplot(5,8,18), imshow(Is);
subplot(5,8,19), imshow(Msi);
subplot(5,8,20),  imshow(Ms);
subplot(5,8,21),  imshow(Mbi);
subplot(5,8,22),  imshow(Mb);
subplot(5,8,23),  imshow(Mbp);
subplot(5,8,24),  imshow(ne);

% """"""""""""""""""""""""""""""""""""""""""""""""""""


% """"""""""""""""""""""""""""""""""""""""""""""""""""
% For Image P4
P4 = imread('Source Image\P4_rgb.jpg');
pid = im2double(P4);
%figure(41), imshow(P4);

% Step 1: Obtain Shadow Image
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
tiff_img = imread('Source Image\P4.tif');
NIR4(:, :, 1) = tiff_img(:, :, 4); 
pidd = im2double(uint8(NIR4));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);        % Is is the shadow image
%figure(42), imshow(Is);

% Step 2: Create Initial Shadow Mask
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);    %Msi is shadow Mask
%figure(43), imshow(Msi);

% Step 3: Filtering Msi
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
Ms = BW2;       % Ms is the shadow mask
%figure(44), imshow(Ms);

% Step 4 & 5: Segmenting Image & obtaining Building Mask
[Mb,Mbi] = segmentation_4(P4);
% Mbi is initial building mask
% Mb is binarized building mask
%figure(45), imshow(Mbi);
%figure(46), imshow(Mb);

% Step 6: Obtain Perimeter of Building, Mbp
Mbc = 1 - Mb;
Mba = imdilate(Mbc, O);
Mbp = (double(Mba) - double(Mb) == 0);     %Mbp is perimeter of building
%figure(47), imshow(Mbp);

% Step 7: Create Artificial Shadows of Buildings
lambda = 173.2 - 70;
info = imfinfo('Source Image\P4_rgb.jpg');
w = info.Width;  
h = info.Height; 
L = 241000000 / (tan(phi * pi / 180) * w * h);
SE = strel('line', L, lambda);
Nse = getnhood(SE);
Ssimmax = imdilate(Mbp, getnhood(SE));
Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
Sar = bitand(Ssimmax, Ms);       % Sar is the artifical shadow
ne = imfuse(Sar, Mb);
ne = imfuse(ne, P4);        % ne is the artifical shadow with building mask
%figure(48), imshow(ne);

% Step 8: Calculate Height Using Jaccard Index
J4 = jaccard(Sar, Ms)

% Subplot
subplot(5,8,25), imshow(P4);
subplot(5,8,26), imshow(Is);
subplot(5,8,27), imshow(Msi);
subplot(5,8,28),  imshow(Ms);
subplot(5,8,29),  imshow(Mbi);
subplot(5,8,30),  imshow(Mb);
subplot(5,8,31),  imshow(Mbp);
subplot(5,8,32),  imshow(ne);

% """"""""""""""""""""""""""""""""""""""""""""""""""""


% """"""""""""""""""""""""""""""""""""""""""""""""""""
% For Image P5
P5 = imread('Source Image\P5_rgb.jpg');
pid = im2double(P5);
%figure(51), imshow(P5);

% Step 1: Obtain Shadow Image
V = 1 / (1 + exp(-a1 *( 1 - pid.^(1 / c1) - b1) ));
tiff_img = imread('Source Image\P5.tif');
NIR5(:, :, 1) = tiff_img(:, :, 4); 
pidd = im2double(uint8(NIR5));
D = V .* pidd;
T = V ./ pidd;
Is = (1 - D) .* (1 - T);        % Is is the shadow image
%figure(52), imshow(Is);

% Step 2: Create Initial Shadow Mask
i1 = rgb2gray(Is);
threshold_value = graythresh(i1);
Msi = imbinarize(rgb2gray(Is), threshold_value);    %Msi is shadow Mask
%figure(53), imshow(Msi);

% Step 3: Filtering Msi
Mv = ~Msi;
BW2 = bwareaopen(Mv, 1234);
Ms = BW2;       % Ms is the shadow mask
%figure(54), imshow(Ms);

% Step 4 & 5: Segmenting Image & obtaining Building Mask
[Mb,Mbi] = segmentation_5(P5);
% Mbi is initial building mask
% Mb is binarized building mask
%figure(55), imshow(Mbi);
%figure(56), imshow(Mb);

% Step 6: Obtain Perimeter of Building, Mbp
Mbc = 1 - Mb;
Mba = imdilate(Mbc, O);
Mbp = (double(Mba) - double(Mb) == 0);     %Mbp is perimeter of building
%figure(57), imshow(Mbp);

% Step 7: Create Artificial Shadows of Buildings
lambda = 173.2 - 70;
info = imfinfo('Source Image\P5_rgb.jpg');
w = info.Width;  
h = info.Height; 
L = 16000000 / (tan(phi * pi / 180) * w * h);
SE = strel('line', L, lambda);
Nse = getnhood(SE);
Ssimmax = imdilate(Mbp, getnhood(SE));
Ssimmax = (double(Ssimmax) - double(Mbc)) == 0;
Sar = bitand(Ssimmax, Ms);       % Sar is the artifical shadow
ne = imfuse(Sar, Mb);
ne = imfuse(ne, P5);        % ne is the artifical shadow with building mask
%figure(58), imshow(ne);

% Step 8: Calculate Height Using Jaccard Index
J5 = jaccard(Sar, Ms)

% Subplot
subplot(5,8,33), imshow(P5);
subplot(5,8,34), imshow(Is);
subplot(5,8,35), imshow(Msi);
subplot(5,8,36),  imshow(Ms);
subplot(5,8,37),  imshow(Mbi);
subplot(5,8,38),  imshow(Mb);
subplot(5,8,39),  imshow(Mbp);
subplot(5,8,40),  imshow(ne);

% """"""""""""""""""""""""""""""""""""""""""""""""""""