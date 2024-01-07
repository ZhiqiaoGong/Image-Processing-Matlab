init = imread('E:\gzq2\学习\大三上\数字图像处理\实验\res\Fig3.tif'); % 读取图像
[R, C,ch] = size(init); % 获取图像大小
timesX = 2; % X轴缩放量
timesY = 2; % Y轴缩放量
res = zeros(timesX * R, timesY * C,ch); % 构造结果矩阵。每个像素点默认初始化为0（黑色）
tras = [1/timesX 0 0; 0 1/timesY 0; 0 0 1]; % 缩放的变换矩阵 

for k = 1:ch
for i = 1 : timesX * R
    for j = 1 : timesY * C
        temp = [i; j; 1];
        temp = tras * temp; % 矩阵乘法
        x = uint8(temp(1, 1));
        y = uint8(temp(2, 1));
        % 变换后的位置判断是否越界
        if (x <= R) & (y <= C) & (x >= 1) & (y >= 1)
            res(i, j,k) = init(x, y,k);
        end
    end
end
end

imshow(uint8(res)); % 显示图像