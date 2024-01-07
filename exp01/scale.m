% 读取图片 
pic1 = imread('lena.jpg');
 
% 缩放倍数
sh=0.2;
sw=0.2;
 
% 计算原图大小
[h,w,ch] = size(pic1);
m1 = [h; w; 0] / 2;
 
% 计算画布大小
nh = round(h);
nw = round(w);
m2 = [nh; nw; 0] / 2;
pic2 = uint8(zeros(nh, nw, ch));

figure;

for t = 1:100
    
    M = [sh, 0, 0; 0, sw, 0; 0, 0, 1];
    M = inv(M); % 求出逆矩阵
    
    for k = 1:ch
        for i = 1:nh
           for j = 1:nw
              des = [i; j ;1];
              ori = round (M*(des-m2)+m1);
              if (ori(1) >= 1 && ori(1) <= h && ori(2) >= 1 && ori(2) <= w)
                 pic2(i, j, k) = pic1(ori(1), ori(2), k); 
              end
           end
        end
    end
    sh=sh+0.03;
    sw=sw+0.03;
    pause(0.01);
    % 显示图像
    imshow(pic2);
end




