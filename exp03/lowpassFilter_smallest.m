imgori = imread("lena3.jpg");
[h,w,ch] = size(imgori);
imgdes = zeros(h,w,ch);

filterSize = 9;  %filterSize>=3
a = floor(filterSize/2);

for k = 1:ch
   for i = 1:h
      for j = 1:w
          
          min = imgori(i,j,k);
          for s = -a:1:a
              for t = -a:1:a
                  if(i+s<w&&j+t<h&&i+s>0&&j+t>0)
                      if(imgori(i+s,j+t,k)<min)
                         min = imgori(i+s,j+t,k);
                      end
                  end
              end
          end    
          imgdes(i,j,k) = min;
          
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