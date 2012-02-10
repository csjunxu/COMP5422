function [ rgb_image ] = hsi2rgb( hsi_image )
%HSI2RGB Transform image from HSI to RGB
% --------------------------------------
% (c) 2012 QING Pei
% http://www.qingpei.me/

hsi_image = im2double(hsi_image);

H=hsi_image(:,:,1);
S=hsi_image(:,:,2);
I=hsi_image(:,:,3);

%% Recover angle theta from normalized value
H = H * 2 * pi;

R=H.*0;
G=R;
B=R;

%% Calculate RGB according to theta
for pixel = 1:numel(H)
    if (0 <= H(pixel)) & (H(pixel) < 2*pi/3)
        B(pixel) = I(pixel) * (1 - S(pixel));
        R(pixel) = I(pixel) * (1 + S(pixel) * cos(H(pixel)) / cos(pi/3 - H(pixel)));
        G(pixel) = 3 * I(pixel) - R(pixel) - B(pixel);
    elseif (2*pi/3 <= H(pixel)) & (H(pixel) < 4*pi/3)
        H(pixel) = H(pixel) - 2*pi/3;
        R(pixel) = I(pixel) * (1 - S(pixel));
        G(pixel) = I(pixel) * (1 + S(pixel) * cos(H(pixel)) / cos(pi/3 - H(pixel)));
        B(pixel) = 3 * I(pixel) - R(pixel) - G(pixel);
    else
        H(pixel) = H(pixel) - 4*pi/3;
        G(pixel) = I(pixel) * (1 - S(pixel));
        B(pixel) = I(pixel) * (1 + S(pixel) * cos(H(pixel)) / cos(pi/3 - H(pixel)));
        R(pixel) = 3 * I(pixel) - G(pixel) - B(pixel);
    end
end

%% Assemble the RGB channels to return value
rgb_image=cat(3,R,G,B);
rgb_image=max(min(rgb_image,1),0);

%% Show images
figure;
subplot(1,2,1), subimage(hsi_image), title('HSI image'), axis off;
subplot(1,2,2), subimage(rgb_image), title('RGB image'), axis off;
end