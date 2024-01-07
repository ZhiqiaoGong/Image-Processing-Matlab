function m = getVar(img)
    [h,w,ch] = size(img);
    v = 0;
    avg=getAvg(img);

    for k = 1:ch
        for i = 1:h
           for j = 1:w
              v=v+(double(img(i,j,k))-avg)^2;
           end
        end
    end
    
    m=[v/(h*w*ch)];
end