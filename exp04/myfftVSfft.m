times = 3;
big = 140;

x = [2:1:big];
myy = zeros(1,big-1);
iny = zeros(1,big-1);

tic;
for j = 2:big
    m = uint8(rand(j,j,3));
    mysum = 0;
    insum = 0;
    for i = 1:times
        t0=toc;
        I1 = fft2(im2double(m));
        t1=toc;
        I2 = fft_d2(m);
        t2=toc;
        mysum = mysum + t2 - t1;
        insum = insum + t1 - t0;
    end
    myy(j-1) = mysum/times;
    iny(j-1) = insum/times;
end

figure;
plot(x,myy);
hold on;
plot(x,iny);
legend({'fft d2','matlab自带fft2'},'Location','NorthWest');
