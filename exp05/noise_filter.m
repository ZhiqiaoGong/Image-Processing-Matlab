function imgdes = noise_filter(type,imgori, filterSize)
    [l,w,ch] = size(imgori);
    
    if(strcmp(type,'arithmetic'))
        count = filterSize*filterSize;
        a = floor(filterSize/2);
        imgdes = zeros(l,w,ch);
        for k = 1:ch
            for i = 1:l
              for j = 1:w        
                  for s = -a:1:a
                      for t = -a:1:a
                          if(i+s<l&&j+t<w&&i+s>0&&j+t>0)
                            imgdes(i,j,k) = imgdes(i,j,k) + double(imgori(i+s,j+t,k));
                          else
                              count = count-1;
                          end
                      end
                  end    
                  imgdes(i,j,k) = imgdes(i,j,k)/count;
                  count = filterSize*filterSize;
              end
            end
        end
    elseif(strcmp(type,'geometric'))
        count = filterSize*filterSize;
        a = floor(filterSize/2);
        imgdes = ones(l,w,ch);
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
    elseif(strcmp(type,'contra_harmonic'))
        Q=filterSize(2);
        a = floor(filterSize(1)/2);
        imgdes = zeros(l,w,ch);
        for k = 1:ch
            for i = 1:l
              for j = 1:w  
                  t1 = 0; t2 = 0;
                  for s = -a:1:a
                      for t = -a:1:a
                          if(i+s<l&&j+t<w&&i+s>0&&j+t>0)
                            t1 = t1 + (double(imgori(i+s,j+t,k)))^(Q+1);
                            t2 = t2 + (double(imgori(i+s,j+t,k)))^(Q);
                          end
                      end
                  end    
                  imgdes(i,j,k) = t1/t2;
              end
            end
        end
    end
end