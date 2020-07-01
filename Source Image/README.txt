Image dataset: A shadow–overlapping algorithm for estimating building heights from VHR satellite images
Date: 01-10-2017

==================================================================================================

a) Description: 

This package contains the dataset (WorldView-3 source images) for the following publication:
 
  "Kadhim, N and Mourshed, M (2017). A shadow–overlapping algorithm for estimating building heights from VHR satellite images, IEEE Geoscience and Remote Sensing Letters (GRSL)."

The dataset contains seven orthorectified and pansharpened images from one of the latest satellites, VHR WorldView-3 (WV3) with a ground sampling distance (GSD) of 40 cm. The images include four multispectral bands (B, G, R, and NIR) with a radiometric resolution of 16 bits per band. The WV3 images were taken with solar elevation (El) and azimuth (Az) angles of 16:3° and 173:2° respectively, and with a maximum off-nadir angle of 27:6°. The spatial reference of the dataset is WGS_1984_UTM_zone_30N. The metadata file associated with the source image is also provided with this package for more details and information about WV3 imageries.

Image source data are hard to come by, which makes it difficult to benchmark progress in algorithmic development. The purpose of publishing the source dataset is to fill this gap and enable the remote sensing community to refine our appraoch or develop new algorithms. Permission has been obtained from the data owner* to publish the source WV3 imageries as a supplemental dataset. 

*Data owner: 
LAND INFO Worldwide Mapping, LLC, includes materials Copyright © DigitalGlobe - Longmont, Colorado. All rights reserved.

==================================================================================================

b) Size:
The sizes of TIFF (B, G, R, and NIR) and JPEG (RGB) images are given in the following Table.

No.  TIFF (MB) JPEG (KB)
---  --------- --------- 
P1    1.00       9.65 
P2    1.50       8.66 
P3    1.50       9.64  
P4    3.00      24.9 
P5   12.0      105

 

==================================================================================================

c) Platform and Environment:

The experiments were performed on an Intel i7 PC at 3:40 GHz and 16GB RAM.

==================================================================================================

d) Displaying images and detailed run/work with the image dataset instructions:

We provided a JPEG format of all test images to easily display its content. However, if users want to display and examine their content and properties in a TIFF image format with bands (B, G, R, and NIR), many software can be used to display satellite images. Data formats, such as a raster format, a raster type, and a raster product are supported in ArcMap and the ArcGIS Server image services REST API. Software, such as QGIS, ERDAS IMAGINE, PCI, MATLAB - image processing toolbox can also display WV3 imageries.

To open and display the dataset using ArcMap, for instance, follow these steps.

1) Click the Add Data button on the Standard toolbar.
2) Click the Look in drop-down arrow and navigate to the folder, database, or server connection that contains your raster data. ...
3) Click the raster data item you want to add.
4) Click Add.

Below are the basic steps for reading an image into the MATLAB workspace.

To run the image file:
1) Identify the image file directory or add its folder to MATLAB path.
2) Read and display an Image by using the imread and imshow commands.
3) Check how the image appears in the workspace by using the whos command.
4) Check the contents of the image file by using the imfinfo function.

==================================================================================================

c) : Authors and affiliations: 

Nada Kadhim
MohammedSalihNM@cardiff.ac.uk, nada.m.kadhim@gmail.com
http://orcid.org/0000-0002-6065-1580
1. Cardiff School of Engineering, Cardiff University, Cardiff, UK
2. Department of Civil Engineering, University of Diyala, Diyala, Iraq

Prof. Monjur Mourshed
MourshedM@cardiff.ac.uk
http://orcid.org/0000-0001-8347-1366
1. Cardiff School of Engineering, Cardiff University, Cardiff, UK

====================================================================================================

d) : License, use and attribution

The image dataset is licensed under a Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0). The details of licensing terms can be found here: https://creativecommons.org/licenses/by-nc/4.0/

The accompanying publication must be cited as:

Kadhim, N and Mourshed, M (2017) A shadow–overlapping algorithm for estimating building heights from VHR satellite images, IEEE Geoscience and Remote Sensing Letters, VOL(ISSUE):PAGES.

