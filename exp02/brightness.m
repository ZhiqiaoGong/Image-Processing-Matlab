imgori = imread("lenalow.jpg");
imgdes = imgori;

%亮度增加（降低）的百分数（可以为负数，即为亮度降低）
timesPer = -40;

%1.简单方式
%imshow( times*img );

%2.相当于遍历像素，逐个加倍
[h,w,ch] = size(imgori);

for k = 1:ch
   for i = 1:h
      for j = 1:w
          if(timesPer>0)
              imgdes(i,j,k) = round((1+timesPer/100)*double(imgori(i,j,k)));
          else
              tmp = round((1+timesPer/100)*double(imgori(i,j,k)));
              if(tmp<0) 
                  tmp=0;
              end
              imgdes(i,j,k)=tmp;
          end       
      end
   end
end

figure;
subplot(1,2,1);
imshow(imgori);
xlabel('原图像');

subplot(1,2,2);
imshow(imgdes);
xlabel('调整后图像');
