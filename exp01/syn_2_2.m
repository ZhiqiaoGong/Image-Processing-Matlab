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
c1 = [l; w; 0] / 2;
 
% 计算画布大小
nl = round(2*l);
nw = round(2*w);
c2 = [nl; nw; 0] / 2;
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
    R = R0*R1*R2;
    R = inv(R); % 求出逆矩阵
    
    for k = 1:ch
        for i = 1:nl
           for j = 1:nw
              p = [i; j ;1];
              
              pp = R*(p-c2)+c1; % 该像素在原图像中的位置（可能是小数）
              low = floor(pp); % 获取该点最邻近的左上角点
              % 双线性插值公式：
              % p1=(1-a)*A+a*B p2=(1-a)*C+a*D p=(1-b)*p1+b*p2
              % p=(1-b)*(1-a)*A+(1-b)*a*B+(1-a)*b*C+a*b*D
              tmp = pp-low;
              a1 = tmp(1);
              b1 = tmp(2);
              if (pp(1) >= 1 && pp(1) <= l && pp(2) >= 1 && pp(2) <= w)
                 pic2(i, j, k) = (1-b1)*(1-a1)*pic1(low(1), low(2), k)+(1-b1)*a1*pic1(low(1)+1, low(2), k)+...
                                (1-a1)*b1*pic1(low(1), low(2)+1, k)+a1*b1*pic1(low(1)+1, low(2)+1, k);
              end
              end
           end
        end
    
    
    % 显示图像
    imshow(pic2);
%end

 




