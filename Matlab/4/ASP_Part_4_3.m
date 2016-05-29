%{
This script collectts data which is plotted in a second script called
'plot_4.3.m' The time evolution of the coefficients, the MSE, and coefficient 
error is collected.

Different modifications of the lms algorithm are used to collect data.
the lms function (line 56) is changed with the varous versions below to compare
algorithm performance.

lms:            default lms algorithm as in 4.2. input u in range of 0.001 -> 0.37 
                for stability

nlms:           normalised lms algorithm with u normalised to signal power in
                filter memory. input u in range of 0 -> 2 for stability.

nlms_gear1:     learning rate directly proportional to absolute error with a cap 
                on the max rate for stability. Use u in range 0 to 1.5. u= 1 works best

nlms_gear2:     learning rate propoertional to exponent of absolute error - estimated min error.
                for error below a threshold proportional to estimated min
                error, learning rate is proportional to (absolute error -
                estimated min error)^2 which allows smaller learning rates
                and greater steady state accuracy.
                u = 1 works best. estimated min error is set inside the
                function. use 0 if unknown.
%}

clc;clear;clf;

N=1000;                %number of iterations
u=1;
o=0.01;                %variance (power) of measurement noise    

b1=[1, 2, 3, 2, 1];    %unknown system
a1=[1];
q=4;                   %order of adaptive system. (co-ef number = order+1)


%loop to allow averaging of 1000 sample functions.    
for i=1:100,    
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

    [ yest, e(:,i), w, ] = nlms_gear2( x, z, u, q ); %Recursively finds Wiener solution  
    
    w=w.*sqrt(v);           %rescale normalised coeficnets back 
    
    %coeff_err(i,:) = ||b1-w||^2 at each timestep n, for each i samplefunctions.
    temp=(ones(N,1)*b1)'-w;
    coef_err(i,:)=ones(1, (q+1))*temp;
    coef_err(i,:)=coef_err(i,:).*coef_err(i,:);
end


figure(1)       %plot the evolution of the weights for a single sample function. (not averaged unlike the plots of MSE, MCE below)
clf;
col=hsv(q);     %colours for the q plots
hold on
for i=1:q,
    plot(w(i,:),'color',col(i,:))
end
hold off
title(['Evolution of weights (NLMS algorithm), u = ' num2str(u)])
ylabel('Weights')
xlabel('Time [samples]')

% This data is (manually) saved  for different algorithm versions and plotted in another script called 'plot_4.3.m'.
mce = mean(coef_err, 1);        %The evolution of ||b1-w||^2 averaged over 1000 samplesfunctions (MCE)
mse = mean((abs(e).*abs(e)),2); %The evolution of mean squared error averaged over 1000 samplefunction simulations

figure(2)
subplot(1,2,1)
plot(10*log10(mse))
title('mse')

xlim([0,500])
subplot(1,2,2)
plot(10*log10(mce))
title('mce')
%the data is (manually) saved and plotted in another script called 'plot_4.3.m'.

