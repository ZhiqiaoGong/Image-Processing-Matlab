% 读取图片 
pic1 = imread('lena.jpg');
 
% 计算复合矩阵
% 平移像素数
x=0;
y=0;
tran=15;
% 缩放倍数s
sh=0.2;
sw=0.2;
% 旋转角度数
th = 0;
 
% 计算原图大小
[l,w,ch] = size(pic1);
c1 = [l; w; 0] / 2;
 
% 计算画布大小
nl = round(2*l);
nw = round(2*w);
c2 = [nl; nw; 0] / 2;
pic2 = uint8(zeros(nl, nw, ch));

figure;

for times = 1:100
    
    R0 = [1, 0, y; 0, 1, x; 0, 0, 1];
    R1 = [sh, 0, 0; 0, sw, 0; 0, 0, 1];
    R2 = [cosd(a), -sind(a), 0; sind(a), cosd(a), 0; 0, 0, 1];
    R = R0*R1*R2;
    R = inv(R); % 求出逆矩阵
    
    for k = 1:ch
        for i = 1:nl
           for j = 1:nw
              p = [i; j ;1];
              pp = R*(p-c2)+c1; % 该像素在原图像中的位置（可能是小数）
              low = floor(pp); % 获取该点最邻近的左上角点
              % 双线性插值公式推导：
              % p1=(1-a)*A+a*B p2=(1-a)*C+a*D p=(1-b)*p1+b*p2
              % p=(1-b)*(1-a)*A+(1-b)*a*B+(1-a)*b*C+a*b*D
              t = pp-low;
              a = t(1);
              b = t(2);
              if (pp(1) >= 1 && pp(1) <= l && pp(2) >= 1 && pp(2) <= w)
                 pic2(i, j, k) = (1-b)*(1-a)*pic1(low(1), low(2), k)+(1-b)*a*pic1(low(1)+1, low(2), k)+...
                                (1-a)*b*pic1(low(1), low(2)+1, k)+a*b*pic1(low(1)+1, low(2)+1, k);
              end
           end
        end
    end
    th=th+3;
    sh=sh+0.05;
    sw=sw+0.05;
    x=x+tran;
    y=y+tran;
    if(times==14) 
        tran=-abs(tran)
    end
    pause(0.02);
    % 显示图像
    imshow(pic2);
end
 




