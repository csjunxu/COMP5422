function [ hsi_image ] = rgb2hsi( rgb_image )
%RGB2HSI Transform image from RGB to HSI
% --------------------------------------
% (c) 2012 QING Pei
% http://www.qingpei.me/

rgb_image = im2double(rgb_image);
R = rgb_image(:,:,1);
G = rgb_image(:,:,2);
B = rgb_image(:,:,3);

%% Calculate the angle theta
% Add eps to the denominator to avoid the division by 0 problem.
% Acknowledgement: Madhu S. Nair
theta = acos((0.5*((R-G)+(R-B)))./((sqrt((R-G).^2+(R-B).*(G-B)))+eps));

%% Calculate Hue based on whether B<=G or not
H = theta/(2*pi);   % H should be normalized to [0,1]
H(B>G) = 1 - H(B>G);

%% Calculate Saturation
% Still, add eps to the denominator to avoid NaNs.
S = 1-3.*(min(min(B,G),R))./(R+G+B+eps);

%% Calculate Intensity
I = (R+G+B)./3;

%% Assemble the HSI channels to return value
hsi_image = cat(3,H,S,I);

%% Show images
figure;
subplot(2,4,1), subimage(rgb_image), title('RGB image'), axis off;
subplot(2,4,2), subimage(R), title('R'), axis off;
subplot(2,4,3), subimage(G), title('G'), axis off;
subplot(2,4,4), subimage(B), title('B'), axis off;
subplot(2,4,5), subimage(hsi_image), title('HSI image'), axis off;
subplot(2,4,6), subimage(H), title('H'), axis off;
subplot(2,4,7), subimage(S), title('S'), axis off;
subplot(2,4,8), subimage(I), title('I'), axis off;
end

