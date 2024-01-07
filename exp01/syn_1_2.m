% 读取图片 
pic1 = imread('Fig3.tif');
 
% 计算复合矩阵
% 平移像素数
movex=50;
movey=50;
tran=15;
% 缩放倍数s
sh=1;
sw=1;
% 旋转角度数
th = 30;
 
% 计算原图大小
[l,w,ch] = size(pic1);
m1 = [l; w; 0] / 2;
 
% 计算画布大小
nl = round(2*l);
nw = round(2*w);
m2 = [nl; nw; 0] / 2;
pic2 = uint8(zeros(nl, nw, ch));

% 多项式
X = zeros(16,1);
A = zeros(16,16);
B = zeros(16,1);

mat = zeros(1,16);

figure;

%for t = 1:60
    
    R0 = [1, 0, movey; 0, 1, movex; 0, 0, 1];
    R1 = [sh, 0, 0; 0, sw, 0; 0, 0, 1];
    R2 = [cosd(th), -sind(th), 0; sind(th), cosd(th), 0; 0, 0, 1];
    M = R0*R1*R2;
    M = inv(M); % 求出逆矩阵
    
    for k = 1:ch
        for i = 1:nl
           for j = 1:nw
              des = [i; j ;1];
              
              ori = M*(des-m2)+m1; % 该像素在原图像中的位置（可能是小数）
              low = floor(ori); % 获取该点最邻近的左上角点
              % 双线性插值公式：
              % p1=(1-a)*A+a*B p2=(1-a)*C+a*D des=(1-b)*p1+b*p2
              % des=(1-b)*(1-a)*A+(1-b)*a*B+(1-a)*b*C+a*b*D
              tmp = ori-low;
              a1 = tmp(1);
              b1 = tmp(2);
              if (ori(1) >= 1 && ori(1) <= l && ori(2) >= 1 && ori(2) <= w)
                 pic2(i, j, k) = pic1(round(ori(1)), round(ori(2)), k); 
              end
              end
           end
        end
    
    
    % 显示图像
    imshow(pic2);
%end

 




