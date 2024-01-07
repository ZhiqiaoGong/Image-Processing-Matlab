imgori = imread("lena3.jpg");
[h,w,ch] = size(imgori);
imgdes = zeros(h,w,ch);
imgdes2 = zeros(h,w,ch);

filterSize = 3;  %filterSize>=3
a = floor(filterSize/2);
% Robertsweight1 = [0 0 0;0 -1 0;0 0 1];
% Robertsweight2 = [0 0 0;0 0 -1;0 1 0];
% Prewittweight1 = [-1 -1 -1;0 0 0;1 1 1];
% Prewittweight2 = [-1 0 1;-1 0 1;-1 0 1];
Sobelweight1 = [-1 -2 -1;0 0 0;1 2 1];
Sobelweight2 = [-1 0 1;-2 0 2;-1 0 1];
add =  0;

for k = 1:ch
   for i = 1:h
      for j = 1:w
          
          for s = -a:1:a
              for t = -a:1:a
                  if(i+s<h&&j+t<w&&i+s>0&&j+t>0)
                    %imgdes(i,j,k) = imgdes(i,j,k) + Sobelweight2(s+a+1,t+a+1)*double(imgori(i+s,j+t,k));
                    imgdes(i,j,k) = imgdes(i,j,k) + Sobelweight1(s+a+1,t+a+1)*double(imgori(i+s,j+t,k)) +...
                                    Sobelweight2(s+a+1,t+a+1)*double(imgori(i+s,j+t,k));
                  else
                      %count = count-1;
                  end
                  
              end
          end    
          imgdes2(i,j,k) = imgdes(i,j,k) + imgori(i,j,k);
      end
   end
end

figure;
subplot(1,3,1);
imshow(imgori);
xlabel('原图像');

subplot(1,3,2);
imshow(uint8(imgdes));
xlabel('调整后图像');

subplot(1,3,3);
imshow(uint8(imgdes2));
xlabel('调整后叠加原图像');