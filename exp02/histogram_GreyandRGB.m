img = imread("lena.jpg");
[h,w,ch] = size(img);

%imhist(img);比较简单的绘制灰度直方图的方式

%手动变为灰度图像所用系数
W=0.30;
V=0.59;
U=0.11;

y = zeros(1,h*w);
yr = zeros(1,h*w);
yg = zeros(1,h*w);
yb = zeros(1,h*w);

%灰度图像
k=1;
for i = 1:h
      for j = 1:w
          r = double(img(i,j,1))/255;
          g = double(img(i,j,2))/255;
          b = double(img(i,j,3))/255;    
          grey = W*r +V*g + U*b;
          
          y(k)=grey;
          yr(k)=r;
          yg(k)=g;
          yb(k)=b;
          
          k=k+1;
      end
end

subplot(2,2,1);
h1=histogram(y,256/4);
title("灰度直方图");

subplot(2,2,2);
h2=histogram(yr,256/4);
title("R通道直方图");
set(gca,'YTick',0:5000:20000);
set(gca,'YTickLabel',{'0','5000','10000','15000','20000'});
set(gca,'XTick',0:0.2:1);
set(gca,'XTickLabel',{'0','0.2','0.4','0.6','0.8','1'});


subplot(2,2,3);
h3=histogram(yg,256/4);
title("G通道直方图");
set(gca,'XTick',0:0.2:1);
set(gca,'XTickLabel',{'0','0.2','0.4','0.6','0.8','1'});
set(gca,'XTick',0:0.2:1);
set(gca,'XTickLabel',{'0','0.2','0.4','0.6','0.8','1'});

subplot(2,2,4);
h4=histogram(yb,256/4);
title("B通道直方图");
set(gca,'XTick',0:0.2:1);
set(gca,'XTickLabel',{'0','0.2','0.4','0.6','0.8','1'});