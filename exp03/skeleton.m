imgori = imread("skeleton.jpg");
[h,w,ch] = size(imgori);
imgb = zeros(h,w,ch);
imgc = zeros(h,w,ch);
imgd = zeros(h,w,ch);
imge = zeros(h,w,ch);
imgf = zeros(h,w,ch);
imgg = zeros(h,w,ch);
imgh = zeros(h,w,ch);

filterSize = 3;  %filterSize>=3
a = floor(filterSize/2);
Lap = [-1 -1 -1; -1 8 -1; -1 -1 -1];

%pic b c
for k = 1:ch
    min =double(imgori(1,1,k));
    max =double(imgori(1,1,k));
   for i = 1:h
      for j = 1:w
        
          for s = -a:1:a
              for t = -a:1:a
                  if(i+s<h&&j+t<w&&i+s>0&&j+t>0)
                    imgb(i,j,k) = imgb(i,j,k) + Lap(s+a+1,t+a+1)*double(imgori(i+s,j+t,k));
                  end
               end
          end
            if(imgb(i,j,k)>max)
                max = imgb(i,j,k); 
            end
            if(imgb(i,j,k)<min)
                min = imgb(i,j,k); 
            end
      end
   end
    
    imgb(:,:,k) = imgb(:,:,k) - min;
    imgb(:,:,k) = 255*imgb(:,:,k)/(max-min);
    
    %L = max-min;
    %imgdes(:,:,k) = 255*(imgdes(i,j,k)-min)/L;

    imgc(:,:,k) =imgb(:,:,k) + double(imgori(:,:,k));
end

%pic c
for k = 1:ch
    min =double(imgc(1,1,k));
    max =double(imgc(1,1,k));
   for i = 1:h
      for j = 1:w
        if(imgc(i,j,k)>max)
            max = imgc(i,j,k); 
        end
        if(imgc(i,j,k)<min)
            min = imgc(i,j,k); 
        end
      end
   end
    
    imgc(:,:,k) = imgc(:,:,k) - min;
    imgc(:,:,k) = 255*imgc(:,:,k)/(max-min);
 
end

%pic d
Sobelweight1 = [-1 -2 -1;0 0 0;1 2 1];
Sobelweight2 = [-1 0 1;-2 0 2;-1 0 1];

for k = 1:ch
    min =imgori(1,1,k);
    max =imgori(1,1,k);
   for i = 1:h
      for j = 1:w         
          for s = -a:1:a
              for t = -a:1:a
                  if(i+s<h&&j+t<w&&i+s>0&&j+t>0)
                    imgd(i,j,k) = imgd(i,j,k) + Sobelweight1(s+a+1,t+a+1)*double(imgori(i+s,j+t,k)) +...
                                    Sobelweight2(s+a+1,t+a+1)*double(imgori(i+s,j+t,k));
                  else
                  end                  
              end
          end  
            if(imgd(i,j,k)>max)
                max = imgd(i,j,k); 
            end
            if(imgd(i,j,k)<min)
                min = imgd(i,j,k); 
            end
      end
  end
    %imgd(:,:,k) = imgd(:,:,k) - min;
    %imgd(:,:,k) = 255*imgd(:,:,k)/(max-min);
end

%pic e
filterSize = 5;  %filterSize>=3
a = floor(filterSize/2);
weight = ones(filterSize,filterSize); %均值滤波器
count = filterSize*filterSize;

for k = 1:ch
    min =imgd(1,1,k);
    max =imgd(1,1,k);
   for i = 1:h
      for j = 1:w       
          for s = -a:1:a
              for t = -a:1:a
                  if(i+s<h&&j+t<w&&i+s>0&&j+t>0)
                    imge(i,j,k) = imge(i,j,k) + weight(s+a+1,t+a+1)*double(imgd(i+s,j+t,k));
                  else
                      count = count-1;
                  end               
              end
          end    
            imge(i,j,k) = imge(i,j,k)/count;
            count = filterSize*filterSize;
            if(imge(i,j,k)>max)
                max = imge(i,j,k); 
            end
            if(imge(i,j,k)<min)
                min = imge(i,j,k); 
            end
      end
   end
    %imge(:,:,k) = imge(:,:,k) - min;
    %imge(:,:,k) = 255*imge(:,:,k)/(max-min);
end

%pic f
imgf = imge.*imgc/255;
% for k = 1:ch
%     min =imgf(1,1,k);
%     max =imgf(1,1,k);
%    for i = 1:h
%       for j = 1:w       
%         if(imgf(i,j,k)>max)
%             max = imgf(i,j,k); 
%         end
%         if(imgf(i,j,k)<min)
%             min = imgf(i,j,k); 
%         end
%       end
%    end
%     imgf(:,:,k) = imgf(:,:,k) - min;
%     imgf(:,:,k) = 255*imgf(:,:,k)/(max-min);
% end

%pic g
imgg = imgf + double(imgori);

%pic h
for k = 1:ch
    min =imgf(1,1,k);
    max =imgf(1,1,k);
   for i = 1:h
      for j = 1:w       
        if(imgf(i,j,k)>max)
            max = imgf(i,j,k); 
        end
        if(imgf(i,j,k)<min)
            min = imgf(i,j,k); 
        end
      end
   end
end
imgh = (max-min)*((imgg/(max-min)).^0.5);

figure;
subplot(2,4,1);
imshow(imgori);
xlabel('(a)');

subplot(2,4,2);
imshow(uint8(imgb));
xlabel('(b)');

subplot(2,4,3);
imshow(uint8(imgc));
xlabel('(c)');

subplot(2,4,4);
imshow(uint8(imgd));
xlabel('(d)');

subplot(2,4,5);
imshow(uint8(imge));
xlabel('(e)');

subplot(2,4,6);
imshow(uint8(imgf));
xlabel('(f)');

subplot(2,4,7);
imshow(uint8(imgg));
xlabel('(g)');

subplot(2,4,8);
imshow(uint8(imgh));
xlabel('(h)');