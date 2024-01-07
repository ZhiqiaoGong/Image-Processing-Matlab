im0 = imread("lena.jpg");
[h,w,ch] = size(im0);
im=rgb2gray(im0);

drawedge=1;%是否绘制边点
thresholde=-1000;
thresholdc=500000;

%计算梯度
ix = getdI(im,1);
iy = getdI(im,2);
ixx=ix.*ix;
iyy=iy.*iy;
ixy=ix.*iy;
%对ABC值进行高斯滤波，平滑，消除一些不必要的孤立点和凸起
ixx=gauss_filter(ixx);
ixy=gauss_filter(ixy);
iyy=gauss_filter(iyy);
m=zeros(2,2);
R=zeros(h,w);
k=0.05;
%计算全部可能角点
for i = 1:h
    for j = 1:w
        m=[ixx(i,j) ixy(i,j);ixy(i,j) iyy(i,j)];
        R(i,j)=det(m)-k*(trace(m)^2);
    end
end
%非极大值抑制
cornors=zeros(h,w);
imgres=im0;
imgres(:,:,1)=im;
imgres(:,:,2)=im;
imgres(:,:,3)=im;
for i = 1:h
    for j = 1:w
        if(i+1<h&&i-1>0&&j+1<w&&j-1>0)
            if(R(i,j)<thresholde)
                if(drawedge==1)
                    imgres(i,j,1)=0;
                    imgres(i,j,2)=255;
                    imgres(i,j,3)=0;
                end
            elseif(R(i,j)>R(i,j-1) && R(i,j)>R(i,j+1) && R(i,j)>R(i+1,j-1) && R(i,j)>R(i+1,j) ...
                && R(i,j)>R(i+1,j+1) && R(i,j)>R(i-1,j-1) && R(i,j)>R(i-1,j) &&R(i,j)>R(i-1,j+1) && R(i,j)>thresholdc)
                cornors(i,j)=1;
                imgres(i,j,1)=255;
                imgres(i,j,2)=0;
                imgres(i,j,3)=0;
            end
        end
    end
end
%绘制角点(画大一点便于观察）
drawsize=4;
for i = 1:h
    for j = 1:w
        if(cornors(i,j)==1)
            if(i+drawsize<h&&j+drawsize<w&&i-drawsize>0&&j-drawsize>0)
                for t=1:drawsize
                    imgres(i,j+t,1)=255;
                    imgres(i,j+t,2)=0;
                    imgres(i,j+t,3)=0;
                    imgres(i,j-t,1)=255;
                    imgres(i,j-t,2)=0;
                    imgres(i,j-t,3)=0;
                    imgres(i-t,j,1)=255;
                    imgres(i-t,j,2)=0;
                    imgres(i-t,j,3)=0;
                    imgres(i+t,j,1)=255;
                    imgres(i+t,j,2)=0;
                    imgres(i+t,j,3)=0;
                end
            end
        end
    end
end

figure;
imshow(uint8(imgres));
