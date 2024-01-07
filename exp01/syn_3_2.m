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

              if (low(1)-1 >= 1 && low(1)+2 <= l && low(2)-1 >= 1 && low(2)+2 <= w)

                  tmp = pp-low;
                  a1 = tmp(1);
                  b1 = tmp(2);

                  B = [double(pic1(low(1)-1, low(2)-1, k));double(pic1(low(1), low(2)-1, k));double(pic1(low(1)+1, low(2)-1, k));double(pic1(low(1)+2, low(2)-1, k));...
                       double(pic1(low(1)-1, low(2)  , k));double(pic1(low(1), low(2)  , k));double(pic1(low(1)+1, low(2)  , k));double(pic1(low(1)+2, low(2)  , k));...
                       double(pic1(low(1)-1, low(2)+1, k));double(pic1(low(1), low(2)+1, k));double(pic1(low(1)+1, low(2)+1, k));double(pic1(low(1)+2, low(2)+1, k));...
                       double(pic1(low(1)-1, low(2)+2, k));double(pic1(low(1), low(2)+2, k));double(pic1(low(1)+1, low(2)+2, k));double(pic1(low(1)+2, low(2)+2, k))];



                  as1 = CalA(mat,low(1)-1, low(2)-1);as2 = CalA(mat,low(1), low(2)-1);as3 = CalA(mat,low(1)+1, low(2)-1);as4 = CalA(mat,low(1)+2, low(2)-1);
                  as5 = CalA(mat,low(1)-1, low(2));as6 = CalA(mat,low(1), low(2));as7 = CalA(mat,low(1)+1, low(2));as8 = CalA(mat,low(1)+2, low(2));
                  as9 = CalA(mat,low(1)-1, low(2)+1);as10 = CalA(mat,low(1), low(2)+1);as11 = CalA(mat,low(1)+1, low(2)+1);as12 = CalA(mat,low(1)+2, low(2)+1);
                  as13 = CalA(mat,low(1)-1, low(2)+2);as14 = CalA(mat,low(1), low(2)+2);as15 = CalA(mat,low(1)+1, low(2)+2);as16 = CalA(mat,low(1)+2, low(2)+2);
                  A = [as1;as2;as3;as4;as5;as6;as7;as8;as9;as10;as11;as12;as13;as14;as15;as16];

                  X = A\B;

                  pic2(i, j, k) = CalA(mat,pp(1),pp(2))*X;
                  
                %%
                  %双三次插值由于计算速度过慢只绘制一帧

                  else if(pp(1) >= 1 && pp(1) <= l && pp(2) >= 1 && pp(2) <= w)
                     pic2(i, j, k) = pic1(round(pp(1)), round(pp(2)), k);                 
                  end
              end
           end
        end
    end
    
    % 显示图像
    imshow(pic2);
%end

 




