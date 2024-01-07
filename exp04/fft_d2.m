function fftd2 = fft_d2(I)
    I=rgb2gray(I);
    I=im2double(I);
    [h,w] = size(I);

    %补零
    nh = 2^ceil(log2(h));
    nw = 2^ceil(log2(w));
    I = padarray(I,[nw-w,nh-h],0,'post');

    %ft
    for i = 1:nh
        I(i,:) = fft_d1(I(i,:));
    end
    for j = 1:nw
        I(:,j) = fft_d1(I(:,j));
    end
    
    fftd2 = I;
end