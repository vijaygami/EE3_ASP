N=1000;                                 %sample number
x = randn(N,1);                         %WGN
q = 8;                                  %MA Filter order

b=ones((q+1),1);                        %filter coefficients
a=[1];

subplot(1,4,1)
[ACF_x, lags] = xcorr(x,'unbiased');    %unbiased autocorrelation estimate
stem(lags,ACF_x);
title(['ACF of WGN of length ', num2str(N)])
xlabel('Correlation lag')
ylabel('ACF')
xlim([-20,20]);


subplot(1,4,2)
y=filter(b,a,x);                        %MA filter
[ACF_y, lags] = xcorr(y,'unbiased');    %unbiased autocorrelation estimate
stem(lags,ACF_y);
title(['ACF of filtered WGN of length ', num2str(N)])
xlabel('Correlation lag')
ylabel('ACF')
xlim([-20,20]);


subplot(1,4,3)
stem([0:q],b);
title(['Filter impulse response, order: ', num2str(q)])
xlabel('Time Index')
ylabel('Amplitude')
axis([-2, 10, 0, 2])


subplot(1,4,4)
[ACF_f, lags] = xcorr(b);   %ACF of (the finite) impulse response of filter
stem(lags,ACF_f);
title('ACF of filter impulse response')
xlabel('Correlation lag')
ylabel('ACF')
xlim([-11, 11])



%MA filter to compute local sample mean
figure(2)

subplot(1,3,1);
plot(x);
title('WGN input')
xlabel('Time index')
ylabel('Amplitude')
axis([0, 200, -3, 3])

%filter order 10
subplot(1,3,2);
y1=filter([(ones((11),1)./10)],[1],x);
plot(y1)
title('Local sample mean (filter order 10)')
xlabel('Time index')
ylabel('Amplitude')
axis([0, 200, -3, 3])

%filter order 50
subplot(1,3,3);
y2=filter([(ones((51),1)./50)],[1],x);
plot(y2)
title('Local sample mean (filter order 50)')
xlabel('Time index')
ylabel('Amplitude')
axis([0, 200, -3, 3])
