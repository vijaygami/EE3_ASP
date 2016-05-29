load RRI_r_e.mat %load both emads and raweeds data
%sample frequency is 4HZ

[ACF_1, lags1]=xcorr(detrend(RRI_trial_1_e), 'unbiased'); %emads data
[ACF_2, lags2]=xcorr(detrend(RRI_trial_2_r), 'unbiased'); %raweeds data
[ACF_3, lags3]=xcorr(detrend(RRI_trial_3_e), 'unbiased'); %emads data

plot(lags1, ACF_1, lags2, ACF_2*10, lags3, ACF_3) %scale trial 2 by 10 just so it can be easily seen on figure
title(['ACF for ECG data'])
xlabel('Correlation lag')
ylabel('ACF')
axis([-250,250, -0.008, 0.008])
legend('Trial 1','Trial 2 (scaled by x10)', 'Trial 3','Location','northeast');

