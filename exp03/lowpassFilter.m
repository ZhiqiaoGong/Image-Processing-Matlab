imgori = imread("lena3.jpg");
[h,w,ch] = size(imgori);
imgdes = zeros(h,w,ch);

filterSize = 5;  %filterSize>=3
a = floor(filterSize/2);
% weight = ones(filterSize,filterSize); %均值滤波器
% count = filterSize*filterSize;
% weight = [1 2 1;2 4 2;1 2 1];
% count = 16;
weight = [0.5 0.5 0.5 0.5 0.5;0.5 1 1 1 0.5;0.5 1 1 1 0.5;0.5 1 1 1 0.5;0.5 0.5 0.5 0.5 0.5];
count = 17;

for k = 1:ch
   for i = 1:h
      for j = 1:w
          
          for s = -a:1:a
              for t = -a:1:a
                  if(i+s<h&&j+t<w&&i+s>0&&j+t>0)
                    imgdes(i,j,k) = imgdes(i,j,k) + weight(s+a+1,t+a+1)*double(imgori(i+s,j+t,k));
                  else
                      count = count-1;
                  end
                  
              end
          end    
          imgdes(i,j,k) = imgdes(i,j,k)/count;
          count = filterSize*filterSize;
      end
   end
end

figure;
subplot(1,2,1);
imshow(imgori);
xlabel('原图像');

subplot(1,2,2);
imshow(uint8(imgdes));
xlabel('调整后图像');