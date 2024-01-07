function fftd1 = fft_d1(p)
    %递归计算fft
    L = length(p);%数组长度
    
    fftd1 = zeros(1,L/2);%保存fft结果
    
    %计算Feven和Fodd
    if L==2
        Feven = p(1);
        Fodd = p(2);
    else
        p_even = p(1:2:L-1);
        p_odd = p(2:2:L);
        Feven = fft_d1(p_even);
        Fodd = fft_d1(p_odd);
    end
    
    %相加计算ft
    for u = 1:L/2
        fodd = Fodd(u)*exp(-1*i*2*pi*(u-1)/L);
        fftd1(u) = Feven(u) + fodd;
        fftd1(u + L/2) = Feven(u) - fodd;
    end
end