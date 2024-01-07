function imgdes = gauss_filter(imgori)
    filterSize = 5;  %filterSize>=3
    a = floor(filterSize/2);
    [h,w,ch] = size(imgori);
    g=fspecial('gaussian',[filterSize filterSize],1);
    imgdes = zeros(h,w,ch);
    for i = 1:h
      for j = 1:w
          for s = -a:1:a
              for t = -a:1:a
                  if(i+s<h&&j+t<w&&i+s>0&&j+t>0)
                    imgdes(i,j) = imgdes(i,j) + g(s+a+1,t+a+1)*double(imgori(i+s,j+t));
                  end
              end
          end    
      end
    end
end