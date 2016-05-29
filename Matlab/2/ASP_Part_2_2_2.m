

N=2000;                                 %sample number
x = randn(N,1);                         %WGN
q = 100;                                %MA Filter order

b=ones((q+1),1);                        %filter coefficients
a=[1];


y=filter(b,a,x);                        %MA filter
[ACF_y, lags] = xcorr(y,'unbiased');    %unbiased autocorrelation estimate
stem(lags,ACF_y);
title(['ACF of filtered WGN of length ', num2str(N)])
xlabel('Correlation lag')
ylabel('ACF')
xlim([-300,300]);








%x=fft(acf);
%plot(abs(x))

%plot(y)
%y_acf=xcorr(y);
%stem(y_acf);
%xlim([9800,10200]);

%plot (abs(fft(y_acf)))


%freqz(ones(9,1), [1])


%h=impz(b,a);
%stem (h)
%y=xcorr (h, 'biased')
%stem(y)