function img = adaptive_mid_filter(img,smax)
    [l,w,ch]=size(img);
    img=double(img);
    img=padarray(img,[smax smax]);
    a = 2;
    %计算每个像素值
    for k = 1:ch
       for i = 1:l+2*smax
            for j = 1:w+2*smax 
                %滤波器
                a=2;
                if(i-a/2>0&&i+a/2<=l+2*smax&&j-a/2>0&&j+a/2<=w+2*smax)
                    while(a+1<=smax)
                        if(i-a/2<=0||i+a/2>l+2*smax||j-a/2<=0||j+a/2>w+2*smax)
                            break;
                        end
                        mat = img(i-a/2:i+a/2,j-a/2:j+a/2,k);
                        z_max = max(max(max(mat)));
                        z_min = max(min(min(mat)));
                        z_med = median(mat(:));
                        a1 = z_med-z_min;
                        a2 = z_med-z_max;
                        if(a1>0&a2<0)
                            b1 = img(i,j,k)-z_min;
                            b2 = img(i,j,k)-z_max;
                            if(b1>0&b2<0)
                                break;
                            else
                                img(i,j,k)=z_med;
                                break;
                            end
                        else
                            a=a+2;
                        end
                    end  
                end
            end
       end
    end
    img=img(smax+1:smax+l,smax+1:smax+w,1:3);
end