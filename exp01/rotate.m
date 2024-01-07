% 读取图片 
pic1 = imread('lena.jpg');
 
% 旋转角度
a = 0;
 
% 计算原图大小
[h,w,ch] = size(pic1);
m1 = [h; w; 0] / 2;
 
% 计算画布大小
maxlen = sqrt(w*w+h*h);
nh = round(maxlen);
nw = round(maxlen);
m2 = [nh; nw; 0] / 2;
pic2 = uint8(zeros(nh, nw, ch));

figure;

for t = 1:100
    
    M = [cosd(a), -sind(a), 0; sind(a), cosd(a), 0; 0, 0, 1];
    M = inv(M); % 求出逆矩阵
    
    for k = 1:ch
        for i = 1:nh
           for j = 1:nw
              des = [i; j ;1];
              ori = M*(des-m2)+m1;
              if (ori(1) >= 1 && ori(1) <= h && ori(2) >= 1 && ori(2) <= w)
                 pic2(i, j, k) = pic1(round(ori(1)), round(ori(2)), k); 
              end
           end
        end
    end
    a=a+3;
    pause(0.05);
    % 显示图像
    imshow(pic2);
end
 




