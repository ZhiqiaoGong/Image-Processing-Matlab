function [m] = getAvg(img)
    [h,w,ch] = size(img);
    s = 0;
    
    for k = 1:ch
        for i = 1:h
           for j = 1:w
              s=s+double(img(i,j,k));
           end
        end
    end
    
    m=[s/(h*w*ch)];
end