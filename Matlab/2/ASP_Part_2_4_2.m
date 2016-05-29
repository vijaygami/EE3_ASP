load sunspot.dat

%ACF of the sunspot time series with different data lengths
sun_5=sunspot([1:5],2);
sun_20=sunspot([1:20],2);
sun_250=sunspot([1:250],2);

[ACF_5, lags_5] = xcorr(sun_5,'unbiased');
[ACF_20, lags_20] = xcorr(sun_20,'unbiased');
[ACF_250, lags_250] = xcorr(sun_250,'unbiased');

figure(1)
subplot(2,3,1)
stem(lags_5,ACF_5);
title(['ACF of sunspot time series, length 5'])
xlabel('Correlation lag (years)')
ylabel('ACF')
xlim([-4,4])


subplot(2,3,2)
stem(lags_20,ACF_20);
title(['ACF of sunspot time series, length 20'])
xlabel('Correlation lag (years)')
ylabel('ACF')



subplot(2,3,3)
stem(lags_250,ACF_250);
title(['ACF of sunspot time series, length 250'])
xlabel('Correlation lag (years)')
ylabel('ACF')
xlim([-100,100])

mean(ACF_250)

%zero mean sunspot time series of lengths 5,20 and 200
sun_5=sunspot([1:5],2) - mean(sunspot([1:5],2));
sun_20=sunspot([1:20],2) - mean(sunspot([1:20],2));
sun_250=sunspot([1:250],2) - mean(sunspot([1:250],2));

[ACF_5, lags_5] = xcorr(sun_5,'unbiased');
[ACF_20, lags_20] = xcorr(sun_20,'unbiased');
[ACF_250, lags_250] = xcorr(sun_250,'unbiased');

subplot(2,3,4)
stem(lags_5,ACF_5);
title(['ACF of zero mean sunspot time series, length 5'])
xlabel('Correlation lag (years)')
ylabel('ACF')
xlim([-4,4])


subplot(2,3,5)
stem(lags_20,ACF_20);
title(['ACF of zero mean sunspot time series, length 20'])
xlabel('Correlation lag (years)')
ylabel('ACF')


subplot(2,3,6)
stem(lags_250,ACF_250);
title(['ACF of zero mean sunspot time series, length 250'])
xlabel('Correlation lag (years)')
ylabel('ACF')
xlim([-100,100])

mean(ACF_250)

