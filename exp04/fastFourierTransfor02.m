I = imread("f5.png");

figure;
subplot(1,3,1);
imshow(uint8(I));
xlabel('原图像');

tic;
I1 = fft2(im2double(I));
t(1)=toc;
I2 = fft_d2_2(I);
t(2)=toc;

I1 = fftshift(I1);
I1 = abs(I1);
I1 = log(I1+1);
mmax = max(max(max(I1)));
mmin = min(min(min(I1)));
I1 = 255*I1./(mmax-mmin);
subplot(1,3,2);
imshow(uint8(I1));
xlabel("自带的FFT耗时："+ num2str(t(1)) + "s");


I2 = fftshift(I2);
I2test = I2;
I2 = abs(I2);
I2 = log(I2+1);
mmax = max(max(max(I2)));
mmin = min(min(min(I2)));
I2 = 255*I2./(mmax-mmin);
subplot(1,3,3);
imshow(uint8(I2));
xlabel("编写迭代FFT耗时："+ num2str(t(2)-t(1)) + "s");

