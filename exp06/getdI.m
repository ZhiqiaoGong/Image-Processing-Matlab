function I = getdI(img,d)
    [h,w,ch] = size(img);
    I = zeros(h,w,ch);
    if(d==2)%dI/dy   
        for i = 1:h
          for j = 1:w
              if(i+1<h&&j+1<w&&i-1>0&&j-1>0)
                I(i,j) = double(img(i+1,j)-img(i-1,j));
              end    
          end
        end
    elseif(d==1)%dI/dx
        for i = 1:h
          for j = 1:w
              if(i+1<h&&j+1<w&&i-1>0&&j-1>0)
                I(i,j) = double(img(i,j+1)-img(i,j-1));
              end    
          end
        end
    end
end