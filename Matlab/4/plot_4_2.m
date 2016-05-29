%plots the data gathered from ASP_Part_4_2.m

load 0.002.mat
load 0.005.mat
load 0.01.mat
load 0.1.mat
load 0.2.mat
load 0.3.mat
load 0.4.mat
load 0.5.mat


figure(1)
subplot(1,2,1)
plot([1:10000],10*log10(mce0_002), [1:10000], 10*log10(mce0_005), [1:10000], 10*log10(mce0_01), [1:10000], 10*log10(mce0_1))
title('Averaged coefficient error 1000 trials')
xlabel('Time [Samples]')
ylabel('10log10( || b - w ||^2 )')
legend('u=0.002', 'u=0.005', 'u=0.01', 'u=0.1')
ylim([-35, 20])
xlim([0, 5000])

subplot(1,2,2)

plot( [1:10000], 10*log10(mce0_2), [1:10000], 10*log10(mce0_3), [1:10000], 10*log10(mce0_4), [1:10000], 10*log10(mce0_5))
title('Averaged coefficient error 1000 trials')
xlabel('Time [Samples]')
ylabel('10log10( || b - w ||^2 )')
legend('u=0.02', 'u=0.3','u=0.4', 'u=0.5')
ylim([-10, 1000])
xlim([0, 5000])




figure(2)
subplot(1,2,1)
plot([1:9999],10*log10(mse0_002), [1:9999], 10*log10(mse0_005), [1:9999], 10*log10(mse0_01), [1:9999], 10*log10(mse0_1))
title('Averaged MSE 1000 trials')
xlabel('Time [Samples]')
ylabel('10log10( MSE )')
legend('u=0.002', 'u=0.005', 'u=0.01', 'u=0.1')
ylim([-22, 2])
xlim([0, 3000])

subplot(1,2,2)

plot( [1:9999], 10*log10(mse0_2), [1:9999], 10*log10(mse0_3), [1:9999], 10*log10(mse0_4), [1:9999], 10*log10(mse0_5))
title('Averaged MSE 1000 trials')
xlabel('Time [Samples]')
ylabel('10log10( MSE )')
legend('u=0.02', 'u=0.3','u=0.4', 'u=0.5')
ylim([-25, 500])
xlim([0, 5000])