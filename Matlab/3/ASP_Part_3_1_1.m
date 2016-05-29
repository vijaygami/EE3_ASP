%zero phase filter used to smooth PSD estimates

plots=3;
rng(1);

for i=1:plots
    N=64*2^i;
    x=randn(N, 1);
    p=pgm(x);
    
    %zero phase FIR filter used to smooth PSD
    ps= filtfilt(0.2*[1, 1, 1, 1, 1], [1], p);
  
    %plotting smoothed PSD
    subplot(1,plots,i)
    plot([0: 1/N : (N-1)/N], 10*log10(ps))
    title(['Smoothed PSD estimate for WGN, Samples:',num2str(N)])
    xlabel('Normalised frequency (x2\pi rad/sample)')
    ylabel('Power/frequency (dB/rad/sample)')
        
end

