img0 = imread("athlete.png");

img1 = fft2(im2double(img0));
img1 = fftshift(img1);
img1 = abs(img1);
img1 = log(img1+1);
mmax = max(max(max(img1)));
mmin = min(min(min(img1)));
img1 = 255*img1./(mmax-mmin);
% img1 = 30*log(img1+1);


figure;
subplot(1,2,1);
imshow(img0);

subplot(1,2,2);
imshow(uint8(img1));


    I=imread('lena3.jpg');
    I=rgb2gray(I);
    I=im2double(I);
    [x,y] = size(I);
    Ax = ones(x,y);
    ans = ones(x,y);
    com = 0+1i;
    % 对每一列进行DFT
    for k =1:x        
        for m=1:y
            sn =0;
            for n =1:x
                sn =sn + I(n,m)*exp(-com*2*pi*k*n/x);
            end
            Ax(k,m) = sn;
        end
    end
    % 对每一行进行DFT
    for l =1:y
        for k =1:x
            sn =0;
            for m=1:y
                sn = sn+Ax(k,m)*exp(-com*2*pi*l*m/y);
            end
            ans(k,l) = sn;
        end
    end    
    F=fftshift(ans);
    F= abs(F);
    F=log(F+1);
    figure(6);


    
    
    
test = [0 1 2 3 4 5 6 7];
a = fft_d1_2(test)
b = fft(test)
abs(a-b)