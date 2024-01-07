     %直方图均衡化    
    clear;  
    I = imread('lenalow.jpg');    
    [height,width] = size(I);    
    figure    
    subplot(221)    
    imshow(I)%显示原始图像    
    subplot(222)    
    imhist(I)%显示原始图像直方图    
        
    %进行像素灰度统计;    
    s = zeros(1,256);%统计各灰度数目，共256个灰度级    
    for i = 1:height    
        for j = 1: width    
            s(I(i,j) + 1) = s(I(i,j) + 1) + 1;%对应灰度值像素点数量增加一    
        end    
    end    
    %计算灰度分布密度    
    p = zeros(1,256);    
    for i = 1:256    
        p(i) = s(i) / (height * width * 1.0);    
    end    
    %计算累计直方图分布    
    c = zeros(1,256);    
    c(1) = p(1);  
    for i = 2:256     
            c(i) = c(i - 1) + p(i);    
    end    
    %累计分布取整,将其数值归一化为1~256   
    c = uint8(255 .* c + 0.5);    
    %对图像进行均衡化  
    for i = 1:height    
        for j = 1: width    
            I(i,j) = c(I(i,j)+1);    
        end    
    end    
      
    subplot(223)    
    imshow(I)%显示均衡化后的图像  
    subplot(224)    
    imhist(I)%显显示均衡化后的图像的直方图    