clc;clear;
load sunspot.dat

sun=sunspot(:,2);           %shorter name for script neatness
N=length(sun);              %length of sunpost series
sun = sun-mean(sun);        %zero mean
sun = sun./sqrt(var(sun));  %unit variance




%Estimating the model with different orders:
[a1, o1] = aryule(sun,1);       %estimated AR coeficients and varaince of white noise input, undermodel
[a2, o2] = aryule(sun,2);       %estimated AR coeficients and varaince of white noise input, sufficnet model
[a9, o9] = aryule(sun,9);       %estimated AR coeficients and varaince of white noise input, optimal model order (MDL, AIC)
[a50, o50] = aryule(sun,50);    %estimated AR coeficients and varaince of white noise input, overmodel

% model based PSD
[h1,w1]=freqz(sqrt(o1), a1, 'whole', 1024);       %p=1, undermodel
[h2,w2]=freqz(sqrt(o2), a2, 'whole', 1024);       %p=2, sufficnet model
[h9,w9]=freqz(sqrt(o9), a9, 'whole', 1024);       %p=9, optimal model order (MDL, AIC) 
[h50,w50]=freqz(sqrt(o50), a50, 'whole', 1024);   %p=50,overmodel


est=2*pgm(sun);      %estimated PSD, multiply by 2 since only half PSD will be shown

                      
%calculateing better estimate by the averaging of smaller segments method
L=48;   %length of segments to be averaged
for i=0:floor(N/L)-1
    est_seg(:, i+1)=2*pgm((sun( (i*L+1) : L*(i+1) )));        %multiply by 2 since only half PSD will be shown
end
est_ave=mean(est_seg, 2);


%plotting model based estimates and PSD estimate to compare
figure(1); clf;
col=hsv(6);  %colours for the p plots

%plotting estimates model estimates. note amplitude doubled since only
%showing half the symetric spectra from 0 -> fs/2
hold on
plot ([[0: 1/N : (N-1)/N]], 10*log10(est), 'color', col(1,:), 'linewidth', 2)
plot ([[0: 1/L : (L-1)/L]],  10*log10(est_ave), 'color','black' , 'linewidth', 2)
plot([w1/(2*pi)], [10*log10(2*abs(h1).^2)], 'color', col(3,:), 'linewidth', 2)
plot([w2/(2*pi)], [10*log10(2*abs(h2).^2)], 'color', col(4,:), 'linewidth', 2)
plot([w9/(2*pi)], [10*log10(2*abs(h9).^2)], 'color', col(5,:), 'linewidth', 2)
plot([w50/(2*pi)], [10*log10(2*abs(h50).^2)], 'color', col(6,:), 'linewidth', 2)
hold off

title('Model based PSD estimate for sunspot series')
xlabel('Normalised frequency (x2\pi rad/sample)')
ylabel('Power/frequency (dB/rad/sample)')
legend('PSD estimate', 'Averaged PSD estimate', 'Model based PSD, p=1', 'Model based PSD, p=2', 'Model based PSD, p=9', 'Model based PSD, p=50')
ylim([-42,30])
xlim([0, 0.5])








