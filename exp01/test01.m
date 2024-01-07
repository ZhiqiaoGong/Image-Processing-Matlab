% 读取图片 E:\gzq2\学习\大三上\数字图像处理\实验\res\yeah3.jpg
im = imread('E:\gzq2\学习\大三上\数字图像处理\实验\res\yeah3.jpg');
 
% 计算旋转矩阵
a = 30;
R = [cosd(a), -sind(a); sind(a), cosd(a)];
R = R'; % 求出旋转矩阵的逆矩阵进行逆向查找
 
% 计算原图大小
sz = size(im);
h = sz(1);
w = sz(2);
ch = sz(3);
c1 = [h; w] / 2;
 
% 计算显示完整图像需要的画布大小
hh = floor(w*sind(a)+h*cosd(a))+1;
ww = floor(w*cosd(a)+h*sind(a))+1;
c2 = [hh; ww] / 2;
 
% 初始化目标画布
im2 = uint8(ones(hh, ww, 3)*128);
for k = 1:ch
    for i = 1:hh
       for j = 1:ww
          p = [i; j];
          pp = round(R*(p-c2)+c1);
          % 逆向进行像素查找
          if (pp(1) >= 1 && pp(1) <= h && pp(2) >= 1 && pp(2) <= w)
             im2(i, j, k) = im(pp(1), pp(2), k); 
          end
       end
    end
end
 
% 显示图像
figure;
imshow(im2);




init = imread('E:\gzq2\学习\大三上\数字图像处理\实验\res\yeah2.jpg'); % 读取图像
[R, C] = size(init); % 获取图像大小
res = zeros( R,  C); % 构造结果矩阵。每个像素点默认初始化为0（黑色）

alfa = -15 * 3.1415926 / 180.0; % 旋转角度
tras = [cos(alfa) -sin(alfa) 0; sin(alfa) cos(alfa) 0; 0 0 1]; % 旋转的变换矩阵

for i = 1 : R
    for j = 1 : C
        temp = [i; j; 1];
        temp = tras * temp;% 矩阵乘法
        x = uint16(temp(1, 1));
        y = uint16(temp(2, 1));
        % 变换后的位置判断是否越界
        if (x <= R) & (y <= C) & (x >= 1) & (y >= 1)
            res(i, j) = init(x, y);
        end
    end
end;

imshow(uint16(res));  % 显示图像
