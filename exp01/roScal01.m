% 读取图片 E:\gzq2\学习\大三上\数字图像处理\实验\res\yeah3.jpg
pic1 = imread('E:\gzq2\学习\大三上\数字图像处理\实验\res\yeah3.jpg');
 
% 计算旋转矩阵
x=100;
y=100;
sh=0.5;
sw=0.5;
R0 = [sh, 0, 0; 0, sw, 0; 0, 0, 1];
R = [1, 0, x; 0, 1, y; 0, 0, 1];
R = R*R0;
R = inv(R);; % 求出逆矩阵
 
% 计算原图大小
[h,w,ch] = size(pic1);
%c1 = [h; l; 0] / 2;
 
% 计算画布大小
nh = round((w+x)*sind(a)+(h+y)*cosd(a));
nw = round((w+x)*cosd(a)+(h+y)*sind(a));
%c2 = [hh; ll; 0] / 2;
pic2 = uint8(zeros(nh, nw, ch));

for k = 1:ch
    for i = 1:nh
       for j = 1:nw
          p = [i; j ;1];
          %pp = R*(p-c2)+c1;
          pp=R*p;
          if (pp(1) >= 1 && pp(1) <= h && pp(2) >= 1 && pp(2) <= w)
             pic2(i, j, k) = pic1(round(pp(1)), round(pp(2)), k); 
          end
       end
    end
end
 
% 显示图像
figure;
imshow(pic2);



