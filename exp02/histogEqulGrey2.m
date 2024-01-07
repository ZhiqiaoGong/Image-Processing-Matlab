imgori = imread("lenalow.jpg");
imgtmp = imgori;
imgdes = imgori;
[h,w,ch] = size(imgori);

pixel = zeros(1,256);
ppixel = zeros(1,256);
hiseql = zeros(1,256);

%手动变为灰度图像所用系数
W=0.30;
V=0.59;
U=0.11;
grey=0;

%计算各像素值出现的次数 先转换成灰度 变换公式由灰度图计算
k=1;
for i = 1:h
    for j = 1:w
        r = double(imgori(i,j,1));
        g = double(imgori(i,j,2));
        b = double(imgori(i,j,3));    
        grey = round(W*r +V*g + U*b);
        imgtmp(i,j,1)=grey;
        pixel(grey+1) = pixel(grey+1)+1;
        k=k+1;
    end
end

%获取各像素出现的概率
for p = 1:256
    ppixel(p) = pixel(p)/double(h*w);
end

%计算变换函数（累积分布函数）
hiseql(1)=ppixel(1);
for ts = 2:256
   hiseql(ts) =  hiseql(ts-1) + ppixel(ts);
end

%对结果进行归一化以及四舍五入
for tz = 1:256
   hiseql(tz) =  round(255*hiseql(tz));
end

%进行直方图均值化 三个通道都使用同个变换函数
for k = 1:ch
    for i = 1:h
       for j = 1:w
          imgdes(i,j,k)=hiseql(imgori(i,j,k)+1);
       end
    end
end

figure;
subplot(3,2,1);
imshow(imgori);
avg=getAvg(imgori);
myvar=getVar(imgori);
str=['均值:' num2str(avg) ' 方差:' num2str(myvar)];
xlabel(str);

subplot(3,2,2);
imhist(imgori);

subplot(3,2,3);
i = imgtmp(:,:,1);
imshow(i);
avg=getAvg(i);
myvar=getVar(i);
str=['均值:' num2str(avg) ' 方差:' num2str(myvar)];
xlabel(str);
subplot(3,2,4);
imhist(i);

subplot(3,2,5);
imshow(imgdes);
avg=getAvg(imgdes);
myvar=getVar(imgdes);
str=['均值:' num2str(avg) ' 方差:' num2str(myvar)];
xlabel(str);

subplot(3,2,6);
imhist(imgdes);