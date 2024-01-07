imgori = imread("lenalow.jpg");
imgdes = imgori;
[h,w,ch] = size(imgori);

%对比度增加（降低）的百分数（可以为负数，即为对比度降低）
contrastPer = 50;

sr = 0;
sg = 0;
sb = 0;
avg = zeros(1,3);

%计算图像各个通道均值
for i = 1:h
   for j = 1:w
      sr=sr+double(imgori(i,j,1));
      sg=sg+double(imgori(i,j,2));
      sb=sb+double(imgori(i,j,3));
   end
end
avg(1) = sr/(h*w);
avg(2) = sg/(h*w);
avg(3) = sb/(h*w);

% 简易的调整对比度方法
if(contrastPer>0)
    for k = 1:ch
        for i = 1:h
           for j = 1:w
              if(imgori(i,j,k)>avg(k))
                  imgdes(i,j,k)=imgori(i,j,k)*(1+contrastPer/100);
              else if(imgori(i,j,k)<avg(k))
                      imgdes(i,j,k)=imgori(i,j,k)*(1-contrastPer/100);
                  end
              end
           end
        end
    end
else if(contrastPer<0)
        for k = 1:ch
            for i = 1:h
               for j = 1:w
                  if(imgori(i,j,k)>avg(k))
                      tmp=imgori(i,j,k)*(1+contrastPer/100);
                      if(tmp<avg(k))
                         tmp=avg(k); 
                      end
                      imgdes(i,j,k)=tmp;
                  else if(imgori(i,j,k)<avg(k))
                        tmp=imgori(i,j,k)*(1-contrastPer/100);
                        if(tmp>avg(k))
                            tmp=avg(k); 
                        end
                        imgdes(i,j,k)=tmp;
                      end
                  end
               end
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
