function [a] = getMid(size,data)
    for i = 1:size-1
        for j = 1:size-2
            if(data(j)>data(j+1))
               tmp = data(j);
               data(j) = data(j+1);
               data(j+1) = tmp;
            end
        end
    end
    
    a = data(round(size/2));
end