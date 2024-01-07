img = imread("lena.jpg");
[l,w,~] = size(img);
img = double(img);

%%
%生成噪声
figure;
subplot(251);
imshow(uint8(img));
title('原图像');
subplot(256);
imhist(uint8(img_guss));
%高斯噪声
noise_gaussian = normrnd(3,20,l,w);
img_guss = img + noise_gaussian;
subplot(252);
imshow(uint8(img_guss));
title('高斯噪声');
subplot(257);
imhist(uint8(img_guss));

%瑞丽噪声
noise_rayleigh = raylrnd(30,l,w);
img_rayl = img + noise_rayleigh;
subplot(253);
imshow(uint8(img_rayl));
title('瑞丽噪声');
subplot(258);
imhist(uint8(img_rayl));

%伽马噪声
noise_gamma = gamrnd(3,10,l,w);
img_gama = img + noise_gamma;
subplot(254);
imshow(uint8(img_gama));
title('伽马噪声');
subplot(259);
imhist(uint8(img_gama));

%P椒=P盐=0.01椒盐噪声
a = 0.01; b = 0.01;
X = rand(l,w); Y = rand(l,w);
c = X <= a;
noise_saltpepper = c;
c = Y >= 1-b;
noise_saltpepper = noise_saltpepper - 2*c;
img_sp = img + 255*noise_saltpepper;
subplot(255);
imshow(uint8(img_sp));
title('椒盐噪声');
subplot(2,5,10);
imhist(uint8(img_sp));

%%
%滤波器
%椒盐噪声
figure;
subplot(251);
imshow(uint8(img_sp));
title('椒盐噪声');
subplot(252);
imshow(uint8(noise_filter('arithmetic',img_sp, 3)));
title('3*3算数均值');
subplot(253);
imshow(uint8(noise_filter('geometric',img_sp, 3)));
title('3*3几何均值');
subplot(254);
imshow(uint8(noise_filter('contra_harmonic',img_sp, [3, 1.5])));  
title('3*3 Q=1.5 逆谐波');
subplot(255);
imshow(uint8(noise_filter('contra_harmonic',img_sp, [3, -1.5])));  
title('3*3 Q=-1.5 逆谐波');

%高斯噪声
subplot(256);
imshow(uint8(img_guss));
title('高斯噪声');
subplot(257);
imshow(uint8(noise_filter('arithmetic',img_guss, 3)));
title('3*3算数均值');
subplot(258);
imshow(uint8(noise_filter('geometric',img_guss, 3)));
title('3*3几何均值');
subplot(259);
imshow(uint8(noise_filter('contra_harmonic',img_guss, [3, 1.5])));  
title('3*3 Q=1.5 逆谐波');
subplot(2,5,10);
imshow(uint8(noise_filter('contra_harmonic',img_guss, [3, -1.5])));  
title('3*3 Q=-1.5 逆谐波');

%椒盐+高斯噪声
figure;
subplot(341);
imshow(uint8(img));
title('原图像');
subplot(342);
imshow(uint8(img_sp));
title('椒盐噪声');
subplot(343);
imshow(uint8(img_guss));
title('高斯噪声');
subplot(344);
img_sp_guss = img_guss + 255*noise_saltpepper;
imshow(uint8(img_sp_guss));
title('椒盐+高斯噪声');
subplot(345);
imshow(uint8(noise_filter('arithmetic',img_guss, 3)));
title('3*3算数均值');
subplot(346);
imshow(uint8(noise_filter('geometric',img_guss, 3)));
title('3*3几何均值');
subplot(347);
imshow(uint8(noise_filter('contra_harmonic',img_guss, [3, 1.5])));  
title('3*3 Q=1.5 逆谐波');
subplot(348);
imshow(uint8(noise_filter('contra_harmonic',img_guss, [3, -1.5])));  
title('3*3 Q=-1.5 逆谐波');
subplot(349);
imshow(uint8(noise_filter('arithmetic',noise_filter('contra_harmonic',img_sp_guss, [3, 1.5]), 3)));
title('1.5逆谐波+算术均值');
subplot(3,4,10);
imshow(uint8(noise_filter('arithmetic',noise_filter('contra_harmonic',img_sp_guss, [3, -1.5]), 3)));
title('-1.5逆谐波+算术均值');
subplot(3,4,11);
imshow(uint8(noise_filter('geometric',noise_filter('contra_harmonic',img_sp_guss, [3, 1.5]), 3)));
title('1.5逆谐波+几何均值');
subplot(3,4,12);
imshow(uint8(noise_filter('geometric',noise_filter('contra_harmonic',img_sp_guss, [3, -1.5]), 3)));
title('-1.5逆谐波+几何均值');

%%
%%自适应中值滤波算法(adaptive median filter)
figure;
subplot(121);
imshow(uint8(img_sp));
title('椒盐噪声');

res = adaptive_mid_filter(uint8(img_sp),5);
subplot(122);
imshow(uint8(res));
title('自适应中值滤波算法');