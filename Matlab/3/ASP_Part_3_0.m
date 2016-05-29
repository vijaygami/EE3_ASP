%testing the pgm function
rng(1);

plots=3; %number of plots
for i=1:plots
    N=64*2^i;
    x=randn(N, 1);
    p=pgm(x);
  
    subplot(1,plots,i)
    plot([0: 1/N : (N-1)/N], 10*log10(p))
    title(['PSD estimate for WGN, Samples:',num2str(N)])
    xlabel('Normalised frequency (x2\pi rad/sample)')
    ylabel('Power/frequency (dB/rad/sample)')
    
    %checking average signal power: (should be equal to varaince = 1)
    power=sum(p)/N
    power=(x'*x)/N %should give the same result as above line
    
    %checking average amplitude: (should be 1)
    m = mean(p)
    
end





