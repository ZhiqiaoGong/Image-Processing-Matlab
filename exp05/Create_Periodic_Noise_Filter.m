img = imread("lena.jpg");
[l,w,ch] = size(img);
figure;
subplot(2,5,1);
imshow(img);
xlabel('原图像');
img_fft = fft2(im2double(img));
img_fft = fftshift(img_fft);
img_fft = abs(img_fft);
img_fft = log(img_fft+1);
mmax = max(max(max(img_fft)));
mmin = min(min(min(img_fft)));
img_fft = 255*img_fft./(mmax-mmin);
subplot(2,5,6);
imshow(uint8(img_fft));

%添加周期噪声
for k = 1:ch
   for i = 1:l
      for j = 1:w        
          img(i,j,k) = img(i,j,k) + 30*sin(30*i)+30*sin(30*j);
      end
   end
end
subplot(2,5,2);
imshow(img);
xlabel('添加噪声后图像');
img_fft0 = fft2(im2double(img));
img_fft0 = fftshift(img_fft0);

img_fft = abs(img_fft0);
img_fft = 30*log(img_fft+1);
subplot(2,5,7);
imshow(uint8(img_fft));


%带阻滤波器
img_fft0_ideal = band_filter(img_fft0,'ideal',[l,w,ch],44.5,9);
subplot(2,5,3);
img_ifft0 = ifftshift(img_fft0_ideal);
img_ifft0 = ifft2(img_ifft0);
img_ifft = abs(img_ifft0);
img_ifft = log(img_ifft+1);
mmax = max(max(max(img_ifft)));
mmin = min(min(min(img_ifft)));
img_ifft = 255*img_ifft./(mmax-mmin);
imshow(uint8(img_ifft));
xlabel('ideal去噪');

img_ifftfft = abs(img_fft0_ideal);
img_ifftfft = 30*log(img_ifftfft+1);
subplot(2,5,8);
imshow(uint8(img_ifftfft));

img_fft0_butw = band_filter(img_fft0,'butterworth',[l,w,ch],44.5,9);
subplot(2,5,4);
img_ifft0 = ifftshift(img_fft0_butw);
img_ifft0 = ifft2(img_ifft0);
img_ifft = abs(img_ifft0);
img_ifft = log(img_ifft+1);
mmax = max(max(max(img_ifft)));
mmin = min(min(min(img_ifft)));
img_ifft = 255*img_ifft./(mmax-mmin);
imshow(uint8(img_ifft));
xlabel('butterworth去噪');

img_ifftfft = abs(img_fft0_butw);
img_ifftfft = 30*log(img_ifftfft+1);
subplot(2,5,9);
imshow(uint8(img_ifftfft));

img_fft0_gaus = band_filter(img_fft0,'gaussian',[l,w,ch],44.5,9);
subplot(2,5,5);
img_ifft0 = ifftshift(img_fft0_gaus);
img_ifft0 = ifft2(img_ifft0);
img_ifft = abs(img_ifft0);
img_ifft = log(img_ifft+1);
mmax = max(max(max(img_ifft)));
mmin = min(min(min(img_ifft)));
img_ifft = 255*img_ifft./(mmax-mmin);
imshow(uint8(img_ifft));
xlabel('gaussian去噪');

img_ifftfft = abs(img_fft0_gaus);
img_ifftfft = 30*log(img_ifftfft+1);
subplot(2,5,10);
imshow(uint8(img_ifftfft));