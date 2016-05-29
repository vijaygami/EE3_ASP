clc;clear;
rng(4);
N=1024;                             %Final length of output y
D=40;                               %Number of initial outputs to discard due to filter transient effects        


b=[1];                              %AR(1) model:
a=[1,0.9];

x=randn(N+D, 1);                    %40 extra samples since first few values are affected by transient response of filter
y=filter(b, a, x);
y=y(D+1 : N+D);                     %output of AR(1)


%Estimating the model:
[a_est, ox_est] = aryule(y,1)       %estimated AR coeficients and varaince of white noise input

yxx=xcorr(y, 'unbiased');           %alternalte method for estimated AR coeff and white noise input
a1_est2 = -yxx(N+1)/yxx(N)       	% gives the same results for the coefficients as the aryule funcion 
ox_est2 = yxx(N)+a1_est2*yxx(N+1)   % only if the biased ACF estimate used. 


% model based PSD
[h,w]=freqz(b, a, 'whole', N);      %ideal PSD of AR(1)
[h1,w1]=freqz(sqrt(ox_est2), [1, a1_est2], 'whole', N);  %model based estimate PSD of AR(1)
est=pgm(y);                         %estimated PSD

segments=8;                         %calculateing better estimate by the averaging of smaller segments method
L=N/segments;                       
for i=0:segments-1
    est_seg(:, i+1)=pgm((y( (i*L+1) : L*(i+1) )));        
end
est_ave=mean(est_seg, 2);


%plotting model based estimates and PSD estimate to compare
figure(1); clf;
hold on
plot ([[0: 1/N : (N-1)/N]], 10*log10(est), 'red')
plot ([[0: 1/L : (L-1)/L]],  10*log10(est_ave), 'color', [0 .5 0], 'linewidth', 1)
plot([w/(2*pi)], [10*log10(abs(h).^2)], 'color', 'blue', 'linewidth', 1)
plot([w1/(2*pi)], [10*log10(abs(h1).^2)], 'color', 'black', 'linewidth', 1)
hold off
title('PSD estimate of AR(1) filtered signal:  a = [1, 0.9]')
xlabel('Normalised frequency (x2\pi rad/sample)')
ylabel('Power/frequency (dB/rad/sample)')
legend('PSD estimate', 'Averaged estimate', 'Ideal PSD', 'model based estimate')
ylim([-15, 35])










