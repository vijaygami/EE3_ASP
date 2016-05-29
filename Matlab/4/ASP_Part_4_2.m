%This script collectts data which is plotted in a second script called
%'plot_4.2.m'
%the time evolution of the coefficients, the MSE, and coefficient error is
%collected. Data has been collected and manually saved for different values of u in
%the range 0.002 to 0.5
clc;clear;

N=1000;               %number of iterations
u=0.01;                %learning rate step size
o=0.01;                %variance (power) of measurement noise    

b1=[1, 2, 3, 2, 1];    %unknown system
a1=[1];
q=4;                   %order of adaptive system. (co-ef number = order+1)


%loop to allow averaging of 1000 sample functions.    
for i=1:10,    
    rng(i);
    x=randn(N,1);           %WGN input.
    x=x-mean(x);            %exactly zero mean
    x=x/sqrt(var(x));       %exactly unit varaince  

    n=randn(N,1);           %measurement noise. zero mean WGN.
    n=n-mean(n);            %exactly zero mean
    n=n/sqrt(var(n));       %exactly unit varaince 
    n=n*sqrt(o);            %variance = o 

    y=filter(b1,a1,x);      %output of unknown system
    v=var(y);
    y=y/sqrt(v);            %normalise output to unit power. SNR is now 10log10(o)
    z=y+n;                  %realsitic measured noisy signal

    [ yest, e(:,i), w ] = lms( x, z, u, q );
    
    w=w.*sqrt(v);           %rescale normalised coeficnets back 
    
    %coeff_err = ||b1-w||^2 at each timestep n, for each i samplefunctions.
    temp=(ones(N,1)*b1)'-w;
    coef_err(i,:)=ones(1, (q+1))*temp;
    coef_err(i,:)=coef_err(i,:).*coef_err(i,:);
end

%{
%used for stability criterion checking. MSE convergence if u < 2/(trace(Rxx))
rxx=xcorr(x,q, 'unbiased');       %only need ACF from lags 0 to lag q.
Rxx=toeplitz(rxx(q+1:q+1+q));     %ACF matrix for lags 0 to q = order. (toeplitz matrix)
trace = trace(Rxx)
%}

figure(1);clf;       %plot the evolution of the weights for a single sample function. (not averaged unlike the plots below)
col=hsv(q+1);     %colours for the q+1 plots
hold on
for i=1:q+1,
    plot( w(i,:),'color',col(i,:))
end
hold off
title(['Evolution of weights, u = ' num2str(u)])
ylabel('Weights')
xlabel('Time [samples]')
%xlim([0,500])


%this data is (manually) saved for diferent values of 'u' and plotted in another script called 'plot_4.2.m'.
mce = mean(coef_err, 1);        %The evolution of ||b1-w||^2 averaged over 1000 samplesfunctions (MCE)
mse = mean((abs(e).*abs(e)),2); %The evolution of mean squared error averaged over 1000 samplefunction simulations





%finding eigenvalues of Rxx to find excess error. (The excess of the MSE of winer
%solution)
rxx=xcorr(z, q, 'unbiased');      %only need ACF from lags 0 to lag q.
Rxx=toeplitz(rxx(q+1:q+1+q));     %ACF matrix for lags 0 to q = order. (toeplitz matrix)
eigen_sum = sum (eig(Rxx))
