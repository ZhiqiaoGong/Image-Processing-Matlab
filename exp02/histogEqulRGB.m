imgori = imread("lenalow.jpg");
imgdes = imgori;
[h,w,ch] = size(imgori);

pixel = zeros(1,256);
ppixel = zeros(1,256);
hiseql = zeros(1,256);
pixelr = zeros(1,256);
ppixelr = zeros(1,256);
hiseqlr = zeros(1,256);
pixelg = zeros(1,256);
ppixelg = zeros(1,256);
hiseqlg = zeros(1,256);
pixelb = zeros(1,256);
ppixelb = zeros(1,256);
hiseqlb = zeros(1,256);

%计算各像素值出现的次数 分三个通道计算
k=1;
for i = 1:h
    for j = 1:w
        r = imgori(i,j,1);
        g = imgori(i,j,2);
        b = imgori(i,j,3);    
        
        pixelr(r+1) = pixelr(r+1)+1;
        pixelg(g+1) = pixelg(g+1)+1;
        pixelb(b+1) = pixelb(b+1)+1;
        
        k=k+1;
    end
end

%获取各像素出现的概率
for p = 1:256
    ppixelr(p) = pixelr(p)/double(h*w);
    ppixelg(p) = pixelg(p)/double(h*w);
    ppixelb(p) = pixelb(p)/double(h*w);
end

%计算变换函数（累积分布函数）
hiseqlr(1)=ppixelr(1);
hiseqlg(1)=ppixelg(1);
hiseqlb(1)=ppixelb(1);
for ts = 2:256
   hiseqlr(ts) =  hiseqlr(ts-1) + ppixelr(ts);
   hiseqlg(ts) =  hiseqlg(ts-1) + ppixelg(ts);
   hiseqlb(ts) =  hiseqlb(ts-1) + ppixelb(ts);
end

%对结果进行归一化以及四舍五入
for tz = 1:256
   hiseqlr(tz) =  round(255*hiseqlr(tz));
   hiseqlg(tz) =  round(255*hiseqlg(tz));
   hiseqlb(tz) =  round(255*hiseqlb(tz));
end

%进行直方图均值化 三个通道分别使用
for i = 1:h
   for j = 1:w
      imgdes(i,j,1)=hiseqlr(imgori(i,j,1)+1);
      imgdes(i,j,2)=hiseqlg(imgori(i,j,2)+1);
      imgdes(i,j,3)=hiseqlb(imgori(i,j,3)+1);
   end
end

figure;
subplot(2,2,1);
imshow(imgori);
avg=getAvg(imgori);
myvar=getVar(imgori);
str=['均值:' num2str(avg) ' 方差:' num2str(myvar)];
xlabel(str);

subplot(2,2,2);
imhist(imgori);

subplot(2,2,3);
imshow(imgdes);
avg=getAvg(imgdes);
myvar=getVar(imgdes);
str=['均值:' num2str(avg) ' 方差:' num2str(myvar)];
xlabel(str);

subplot(2,2,4);
imhist(imgdes);