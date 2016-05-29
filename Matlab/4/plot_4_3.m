%plots the data gathered from ASP_Part_4_3.m
clc;clear;clf;
load 0.01.mat               %benchmark to compare 'geared' results with.
load gear1.mat              %'geared' results. 
load gear2.mat
load nlms_0.5.mat
load nlms_1.mat



figure(1);clf;
subplot(1,3,1)
plot([1:9999],10*log10(mse0_01), [1:4999], 10*log10(mse_nlms_0_5), [1:4999], 10*log10(mse_nlms_1), [1:4999], 10*log10(mse_gear1), [1:4999], 10*log10(mse_gear2))
title('Averaged MSE 1000 trials')
xlabel('Time [Samples]')
ylabel('10log10( MSE )')
legend('lms, u=0.01', 'nlms, u=0.5', 'nlms, u=1', 'gear1', 'gear2')
ylim([-22, 3])
xlim([0, 500])

subplot(1,3,2)
plot([1:10000],10*log10(mce0_01), [1:5000], 10*log10(mce_nlms_0_5), [1:5000], 10*log10(mce_nlms_1), [1:5000], 10*log10(mce_gear1), [1:5000], 10*log10(mce_gear2))
title('Averaged coefficient error (MSCE) 1000 trials')
xlabel('Time [Samples]')
ylabel('10log10( || b - w ||^2 )')
legend('lms, u=0.01', 'nlms, u=0.5', 'nlms, u=1', 'gear1', 'gear2')
ylim([-35, 20])
xlim([0, 4000])

subplot(1,3,3)
plot([1:10000],10*log10(mce0_01), [1:5000], 10*log10(mce_nlms_0_5), [1:5000], 10*log10(mce_nlms_1), [1:5000], 10*log10(mce_gear1), [1:5000], 10*log10(mce_gear2))
title('Averaged coefficient error (MSCE) 1000 trials (zoomed)')
xlabel('Time [Samples]')
ylabel('10log10( || b - w ||^2 )')
legend('lms, u=0.01', 'nlms, u=0.5', 'nlms, u=1', 'gear1', 'gear2')
ylim([-35, 20])
xlim([0, 500])


