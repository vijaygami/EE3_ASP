clc;clear;rng(4);
%plotting AR(1) process in time domain
N=1024;                         %Final length of output y
D=40;                           %Number of initial outputs to discard due to filter transient effects        

x=randn(N+D, 1);                %40 extra samples since first few values are affected by transient response of filter
y=filter([1], [1,0.9], x);
y=y(D+1 : N+D);

figure(1); clf;                 %plot the filter input
subplot(2,1,1)
plot([1:N], x(D+1:N+D))
xlim([1,N])
title('WGN input')
xlabel('Time index')
ylabel('Amplitude')
xlim([400,800])                 


subplot(2,1,2)                  %plot the filter output
plot([1:N], y)
xlim([1,N])
title('Output of AR(1):   x[n] = -0.9x[n-1] + w[n]')
xlabel('Time index')
ylabel('Amplitude')
xlim([400,800])

%1)________________________________________________________________________
b=[1];
a=[1,0.9];
[h,w]=freqz(b, a, 'whole', N);     %ideal PSD of AR(1)
est=pgm(y);                     %estimated PSD

%calculateing better estimate by the averaging of smaller segments method
segments=8;
L=N/segments;

for i=0:segments-1
    est_seg(:, i+1)=pgm((y( (i*L+1) : L*(i+1) )));        
end
est_ave=mean(est_seg, 2);

%plotting estimates and ideal to compare
figure(2); clf;
subplot(1,2,1)
hold on
plot ([[0: 1/N : (N-1)/N]], 10*log10(est), 'red')
plot ([[0: 1/L : (L-1)/L]],  10*log10(est_ave), 'color', [0 .5 0], 'linewidth', 2)
plot(w/(2*pi), 10*log10(abs(h).^2), 'linewidth', 2)
hold off
title('PSD estimate of AR(1) filtered signal:  a = [1, 0.9]')
xlabel('Normalised frequency (x2\pi rad/sample)')
ylabel('Power/frequency (dB/rad/sample)')
legend('PSD estimate', 'Averaged estimate', 'Ideal PSD')
ylim([-15, 35])

subplot(1,2,2) %closeup in range 0.4 0 - 0.6
hold on
plot ([[0: 1/N : (N-1)/N]], est, 'red')
plot ([[0: 1/L : (L-1)/L]],  est_ave, 'color', [0 .5 0], 'linewidth', 2)
plot(w/(2*pi), abs(h).^2, 'linewidth', 2)
hold off
title('PSD estimate of AR(1) filtered signal zoomed, non log scale')
xlabel('Normalised frequency (x2\pi rad/sample)')
ylabel('Power/frequency (dB/rad/sample)')
legend('PSD estimate', 'Averaged estimate', 'Ideal PSD')
xlim([0.4, 0.6])
ylim([0, 250])


figure(3); zplane(b,a);         %zero pole plot in zplane to explain shape of PSD 
title('Zero pole locations of the filter')







