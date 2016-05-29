%same script as ASP_Part_4_1_1, but now all enclosed in a 'for' loop to
%collect results for performance vs different SNR. (SNR chnages each loop
%iteration)

clc;clear;
for i=1:10,
    
    rng(1); 

    N=1000;                 %number of input samples
    q=4;                    %filter order;
    o=0.1*i;                %measurement additive noise power variance;

    x=randn(N,1);           %WGN input.
    x=x-mean(x);            %exactly zero mean
    x=x/sqrt(var(x));       %exactly unit varaince   

    n=randn(N,1);           %measurement zero mean WGN.
    n=n-mean(n);            %exactly zero mean
    n=n/sqrt(var(n));       %exactly unit varaince 
    n=n*sqrt(o);            %variance = o 

    b=[1,2,3,2,1];          %unknown system:
    a=[1];
    y=filter(b,a,x);

    v=sqrt((var(y)));       %power of output
    y=y./sqrt((var(y)));    %normalise output power
    z=y+n;                  %measured noisy output

    %calculated SNR in dB. theoretically should be 20dB assuiming input is
    %exactly zero mean, hence output is also zero mean, and therefore power of (normalised)
    %output is 1. assuming noise is exactly zero mean, noise power =
    %0.1^2=0.01. 
    snr1(i,1)=snr(y,n);

    rxx=xcorr(x,q, 'unbiased');       %only need ACF from lags 0 to lag q.
    Rxx=toeplitz(rxx(q+1:q+1+q));     %ACF matrix for lags 0 to q = order. (toeplitz matrix)

    pzx_t=xcorr(z,x, q,'unbiased');   %cross corelation
    pzx=pzx_t(q+1:q+1+q);             %cross corelation for lags 0 to q = order.

    %w=inv(Rxx)*(pzx);       %optimum Weiner filter solution
    w = Rxx\pzx;              % This produces the solution using Gaussian elimination, without forming the inverse. can be more efficinet. 

    yest=filter(w, 1, x);             %estimated output used to compute the minimum MSE
    mmse(i,1)=mean((z-yest).*(z-yest));             %(should be equal to the varaince of the measurement noise n)

    %rescale the estimated coeficents to allow comparison with 'unknown' model and estimatated model
    w=w*v;                                          %v = variance of y before it was normalised to unit power
    coef_err(i,1)=mean((abs(w-b')./b'))*100;        %average absolute percentage difference in all coeficnets

    jmin(i,1)=o;                                    %theoretical min noise vs SNR
end

p=plot(snr1, mmse, snr1, coef_err, snr1, jmin );
set(gca,'YScale','log')                             %y-axis to log to allow better comparison
set(p(1),'linewidth',2);
title(['Wiener solution vs SNR, input length: ' num2str(N)])
xlabel('SNR')
ylabel('performance measures (log axis)')
legend('MMSE','Ave % coeficient error', 'Theoretical Min MSE')
grid on
xlim([-10, 10])


