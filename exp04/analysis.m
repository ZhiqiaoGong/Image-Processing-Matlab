largest = 20;
MaxM = 2^largest;
test_2_array = cell(1,largest);
for i = 1:largest
    test_2_array{i} = uint8(256*rand(2,2^i,3));
end

tic
fftimes = ones(1,largest);
fftimes(1:5) = fftimes(1:5)*100;
time_cost = zeros(2,largest);
for i = 1:largest
    for j = 1:fftimes(i)
        fft2(test_2_array{i});
    end
    time_cost(1,i) = double(toc)/double(fftimes(i));
    for j = 1:fftimes(i)
        fft_d2(test_2_array{i});
    end
    time_cost(2,i) = double(toc)/double(fftimes(i));
end

figure
plot(1:largest,time_cost(1,:));
hold on
plot(1:largest,time_cost(2,:));
title("耗时")
legend({'matlab自带fft2','myfft2'})

figure
plot(2.^(1:largest),time_cost(1,:));
hold on
plot(2.^(1:largest),time_cost(2,:));
title("耗时（长度取2的指数）")
legend({'matlab自带fft2','myfft2'})
