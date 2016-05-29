%(1)_______________________________________________________________________
N=1000                                  %sample number
x = randn(N,1);                         %WGN

[ACF_x, lags] = xcorr(x,'unbiased');    %unbiased autocorrelation estimate

stem(lags,ACF_x);
title(['ACF for realisation of WGN of length ', num2str(N)])
xlabel('Correlation lag')
ylabel('ACF')
xlim([-999,999]);
