function res = band_filter(img,type,sz,D0,W)
    l=sz(1); w=sz(2); ch=sz(3);
    filter = zeros(l,w,ch);
    %带阻滤波器
    bwn = 1;
    if(strcmp(type,'ideal'))
        for k = 1:ch
           for i = 1:l
              for j = 1:w 
                  d = sqrt((i-l/2)^2+(j-w/2)^2);
                  if(d>D0-W/2 && d<D0+W/2)
                      filter(i,j,k)=0;
                  else
                      filter(i,j,k)=1;
                  end
              end
           end
        end
    elseif(strcmp(type,'butterworth'))
        for k = 1:ch
           for i = 1:l
              for j = 1:w 
                  d = sqrt((i-l/2)^2+(j-w/2)^2);
                  filter(i,j,k) = 1/(1+(d*W/(d*d-D0*D0))^(2*bwn));
              end
           end
        end
    elseif(strcmp(type,'gaussian'))
        for k = 1:ch
           for i = 1:l
              for j = 1:w 
                  d = sqrt((i-l/2)^2+(j-w/2)^2);
                  filter(i,j,k) = 1-exp(-0.5*((d*d-D0*D0)/(d*W))^2);
              end
           end
        end
    end
    %滤波
    res=img.*filter;
end