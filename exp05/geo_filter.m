function imgdes = geo_filter(imgori, filterSize)
    [l,w,ch] = size(imgori);
    imgdes = ones(l,w,ch);
    a = floor(filterSize/2);
    count = filterSize*filterSize;

    for k = 1:ch
       for i = 1:l
          for j = 1:w        
              for s = -a:1:a
                  for t = -a:1:a
                      if(i+s<l&&j+t<w&&i+s>0&&j+t>0)
                        imgdes(i,j,k) = imgdes(i,j,k) * double(imgori(i+s,j+t,k));
                      else
                          count = count-1;
                      end
                  end
              end    
              tmp = 1/(count);
              imgdes(i,j,k) = imgdes(i,j,k)^tmp;
              count = filterSize*filterSize;
          end
       end
    end
end