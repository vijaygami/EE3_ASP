%plots the data gathered from ASP_Part_4_4.m
clc;clear;clf;
load 4.4_0.001.mat 
load 4.4_0.01.mat               
load 4.4_0.1.mat 
%load 4.4_0.2.mat




figure(1);clf;
subplot(1,2,1)
plot([1:4999], 10*log10(mse_0_001), [1:4999], 10*log10(mse_0_01), [1:4999], 10*log10(mse_0_1))
title('Averaged MSE 5000 trials')
xlabel('Time [Samples]')
ylabel('10log10( MSE )')
legend('u=0.001', 'u=0.01', 'u=0.1', 'u=0.2', 'u=0.3')
%ylim([-22, 3])
%xlim([0, 500])

subplot(1,2,2)
plot([1:5000], 10*log10(mce_0_001), [1:5000], 10*log10(mce_0_01), [1:5000], 10*log10(mce_0_1))
title('Averaged coefficient error (MSCE) 5000 trials')
xlabel('Time [Samples]')
ylabel('10log10( || b - w ||^2 )')
legend('u=0.001', 'u=0.01', 'u=0.1', 'u=0.2', 'u=0.3')
%ylim([-22, 3])
%xlim([0, 500])

