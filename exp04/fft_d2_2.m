function fftd22 = fft_d2_2(I)
    I=rgb2gray(I);
    I=im2double(I);
    [h,w] = size(I);
    %补零
    nh = 2^ceil(log2(h));
    nw = 2^ceil(log2(w));
    I = padarray(I,[nw-w,nh-h],0,'post');
    
    %ft
    [nh,nw] = size(I);
    for i = 1:nh
        I(i,:) = fft_d1_2(I(i,:));
    end
    for j = 1:nw
        I(:,j) = fft_d1_2(I(:,j));
    end
    
    fftd22 = I;
end