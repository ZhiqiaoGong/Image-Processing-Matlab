function imgdes = invhar_filter(imgori, filterSize, Q)
    [l,w,ch] = size(imgori);
    imgdes = zeros(l,w,ch);
    a = floor(filterSize/2);

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