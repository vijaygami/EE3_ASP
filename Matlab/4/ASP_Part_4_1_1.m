clc;clear;
rng(1);

%_Weiner filter_____________________________________________________________

N=1000;                 %number of input samples
q=4;                    %filter order;
o=0.1;                  %measurement additive noise power standard deviation;

x=randn(N,1);           %WGN input.
x=x-mean(x);            %exactly zero mean
x=x/sqrt(var(x));       %exactly unit varaince   

n=randn(N,1);           %measurement zero mean WGN.
n=n-mean(n);            %exactly zero mean
n=n/sqrt(var(n));       %exactly unit varaince 
n=n*o;                  %std. dev. = o 

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
snr=snr(y,n)

rxx=xcorr(x,q, 'unbiased');       %only need ACF from lags 0 to lag q.
Rxx=toeplitz(rxx(q+1:q+1+q));     %ACF matrix for lags 0 to q = order. (toeplitz matrix)

pzx_t=xcorr(z,x, q,'unbiased');   %cross corelation
pzx=pzx_t(q+1:q+1+q);             %cross corelation for lags 0 to q = order.

%w=inv(Rxx)*(pzx);       %optimum Weiner filter solution
w = Rxx\pzx;             % This produces the solution using Gaussian elimination, without forming the inverse. can be more efficinet. 


yest=filter(w, 1, x);             %estimated output used to compute the minimum MSE
mmse=mean((z-yest).*(z-yest))     %(should be equal to the varaince of the measurement noise n)

%rescale the estimated coeficents to allow comparison with 'unknown' model and estimatated model
w=w*v   %v = variance of y before it was normalised to unit power
coef_err=mean((abs(w-b')./b'))*100           %average absolute percentage difference in all coeficnets




