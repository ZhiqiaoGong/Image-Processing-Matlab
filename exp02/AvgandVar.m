imgori = imread("lenalow.jpg");
[h,w,ch] = size(imgori);

s = zeros(1,3);
avg = zeros(1,4);
v = zeros(1,4);
var = zeros(1,4);

%计算图像均值
for k = 1:ch
    for i = 1:h
       for j = 1:w
          s(k)=s(k)+double(imgori(i,j,k));
       end
    end
end
avg(1) = s(1)/(h*w);
avg(2) = s(2)/(h*w);
avg(3) = s(3)/(h*w);
avg(4) = (sr+sg+sb)/(3*h*w);

%计算图像方差
for k = 1:ch
    for i = 1:h
       for j = 1:w
          v(k)=v(k)+(double(imgori(i,j,k))-avg(k))^2;
       end
    end
end
for k = 1:ch
    for i = 1:h
       for j = 1:w
          v(4)=v(4)+(double(imgori(i,j,k))-avg(4))^2;
       end
    end
end
var(1) = v(1)/(h*w);
var(2) = v(2)/(h*w);
var(3) = v(3)/(h*w);
var(4) = v(4)/(3*h*w);

str=['R通道的均值：' num2str(avg(1)) ' R通道的方差：' num2str(var(1))];
disp(str);
str=['G通道的均值：' num2str(avg(2)) ' G通道的方差：' num2str(var(2))];
disp(str);
str=['B通道的均值：' num2str(avg(3)) ' B通道的方差：' num2str(var(3))];
disp(str);
str=['全部通道的均值：' num2str(avg(4)) ' 全部通道的方差：' num2str(var(4))];
disp(str);


