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
a = 0;
 
% 计算原图大小
[l,w,ch] = size(pic1);
m1 = [l; w; 0] / 2;
 
% 计算画布大小
nl = round(2*l);
nw = round(2*w);
m2 = [nl; nw; 0] / 2;
pic2 = uint8(zeros(nl, nw, ch));

figure;

for t = 1:60
    
    M0 = [1, 0, y; 0, 1, x; 0, 0, 1];
    M1 = [sh, 0, 0; 0, sw, 0; 0, 0, 1];
    M2 = [cosd(a), -sind(a), 0; sind(a), cosd(a), 0; 0, 0, 1];
    M = M0*M1*M2;
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
                 pic2(i, j, k) = (1-b1)*(1-a1)*pic1(low(1), low(2), k)+(1-b1)*a1*pic1(low(1)+1, low(2), k)+...
                                (1-a1)*b1*pic1(low(1), low(2)+1, k)+a1*b1*pic1(low(1)+1, low(2)+1, k);
              end
              
              
           end
        end
    end
    a=a+3;
    sh=sh+0.05;
    sw=sw+0.05;
    x=x+tran;
    y=y+tran;
    if(t==14) 
        tran=-abs(tran)
    end
    if(t==40)
        tran=20;
    end
    pause(0.02);
    % 显示图像
    imshow(pic2);
end
 



