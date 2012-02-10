%% Load a demo image
% image = imread('onion.png');
image = imread('kodak_fence.tif');
% imshow(image);

%% RGB2HSI
hsi_image = rgb2hsi(image);

%% HSI2RGB
rgb_image = hsi2rgb(hsi_image);

%% Diff between original and the result after two transformations
figure,imshow(rgb_image-double(image));