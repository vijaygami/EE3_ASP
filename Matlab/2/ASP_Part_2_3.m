%(1)_______________________________________________________________________
N=1000;                                %sample number
x = randn(N,1);                        %WGN
q = 8;                                 %MA Filter order

b=ones((q+1),1);                       %filter coefficients
a=[1];

y=filter(b,a,x);
[CCF_xy, lags] = xcorr(y,x,'unbiased');    %unbiased cross corelation estimate: Rxy(lags)
stem(lags,CCF_xy);
title('CCF between WGN input and filtered output')
xlabel('Correlation lag')
ylabel('CCF')
xlim([-20,20]);

