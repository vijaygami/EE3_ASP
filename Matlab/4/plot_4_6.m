%plots the data gathered from ASP_Part_4_6.m
clc;clear;clf;
load 4.6_lms.mat 
load 4.6_sign_error.mat 
load 4.6_sign_reg.mat 
load 4.6_sign_sign.mat        


figure(1);clf;
subplot(1,2,1)
plot([1:1999], 10*log10(mse_lms), [1:1999], 10*log10(mse_se), [1:1999], 10*log10(mse_sr) , [1:1999], 10*log10(mse_ss))
title('Averaged MSE 5000 trials')
xlabel('Time [Samples]')
ylabel('10log10( MSE )')
legend('lms', 'sign', 'sign regressor', 'sign sign')
%ylim([-22, 3])
xlim([0, 1200])

subplot(1,2,2)
plot([1:2000], 10*log10(mce_lms), [1:2000], 10*log10(mce_se), [1:2000], 10*log10(mce_sr), [1:2000], 10*log10(mce_ss))
title('Averaged coefficient error (MSCE) 5000 trials')
xlabel('Time [Samples]')
ylabel('10log10( || b - w ||^2 )')
legend('lms', 'sign', 'sign regressor', 'sign sign')
%ylim([-22, 3])
%xlim([0, 500])

