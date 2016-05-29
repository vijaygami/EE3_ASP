%zero phase filter used to smooth PSD estimates
clc;clear;
N=1024;
segments=8;
L=N/segments;

figure(1)
for i=0:segments-1
    
    x=randn(N, 1);
    p(:, i+1)=pgm((x( (i*L+1) : L*(i+1) )));
  
    subplot(2,segments/2,i+1)
    plot( [0: 1/L : (L-1)/L] , 10*log10(p(:,i+1)))
    title(['PSD estimate for WGN, Samples:',num2str(L)])
    xlabel('Normalised frequency (x2\pi rad/sample)')
    ylabel('Power/frequency (dB/rad/sample)')
        
end

%average the L periodogram:
figure(2)
p_ave=mean(p,2);

mean(p_ave)
var(p_ave)

plot([0: 1/L : (L-1)/L], 10*log10(p_ave))
title('Averaged periodogram estimate for WGN')
xlabel('Normalised frequency (x2\pi rad/sample)')
ylabel('Power/frequency (dB/rad/sample)')
ylim([-5,5])

%compare to smoothed periodogram  (FIR order 8)
p_2=pgm(x);
p_2_s=filtfilt( (1/8)*[1, 1, 1, 1, 1, 1, 1, 1] ,[1] , p_2);

mean(p_2_s)
var(p_2_s)

figure(3)
plot([0: 1/N : (N-1)/N], 10*log10(p_2_s) )
title('Smoothed PSD estimate for WGN, FIR order 8')
xlabel('Normalised frequency (x2\pi rad/sample)')
ylabel('Power/frequency (dB/rad/sample)')
ylim([-5,5])