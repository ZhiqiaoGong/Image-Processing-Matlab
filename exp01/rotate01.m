init = imread('E:\gzq2\学习\大三上\数字图像处理\实验\res\yeah2.jpg'); % 读取图像

[R, C] = size(init); % 获取图像大小
res = zeros(R,  C); % 构造结果矩阵。每个像素点默认初始化为0（黑色）

alfa = -15 * pi / 180.0; % 旋转角度
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

imshow(uint8(res));  % 显示图像