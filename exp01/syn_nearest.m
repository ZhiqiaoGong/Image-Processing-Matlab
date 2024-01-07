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
              ori = round( M*(des-m2)+m1 ); % 临近插值
              %ori = round( M*des );
              if (ori(1) >= 1 && ori(1) <= l && ori(2) >= 1 && ori(2) <= w)
                 pic2(i, j, k) = pic1(ori(1), ori(2), k); 
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
    pause(0.01);
    % 显示图像
    imshow(pic2);
end
 



