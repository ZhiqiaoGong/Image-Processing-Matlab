function fftd12 = fft_d1_2(p)
    %迭代计算fft
    L = length(p);%数组长度
    %二进制翻转
    p2 = zeros(1,L);
    n = length(dec2bin(L))-1;
    for i = 0:L-1
        s1 = dec2bin(i,n);
        b = size(s1);                       
        s2 = s1(b(2):-1:1);    
        p2(i+1)= p(bin2dec(s2)+1);
    end
    p=p2;
    
    stride=1;
    while stride<L
        we = exp(-1i*pi/stride);
        
        j=1; %当前所在序列的索引
        while j<=L 
            wn = 1+0*i;
           
            k=0;
            while k<stride %序列内计算
                x = p(j+k);
                y = wn*p(j+k+stride);
                p(j+k) = x+y;
                p(j+k+stride) = x-y;
                wn = wn*we;
                
                k=k+1;
            end
            
            j=j+stride*2;
        end
        
        stride=stride*2;
    end
    
    fftd12=p;
end