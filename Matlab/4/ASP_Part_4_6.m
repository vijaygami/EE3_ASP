clc;clear;clf;

N=2000;                 %number of input samples
p=2;                    %AR process order;
u=0.01;                 %adaptation gain
sw=1;                   %software switch for lms_AR. 1 -> (signed - error), 2 -> (signed - regressor), 3 -> (sign - sign) , (0 for default lms.)

b1=[1];                 %AR model for sythesis stage
a1=[1, 0.9, 0.2];


tic                     %used to measure performance in terms of runtime

%loop used to collect data for MSE, MSCE averaged over 5000 trails.

for i=1:5000,            %number of trials to average across
    rng(i)    
    n=randn(N,1);           %WGN input.
    x=filter(b1,a1,n);      %output of filter
    std=sqrt(var(x));
    [ y, e(:,i), a ] = lms_sign( (x./std), u, p, sw); %input 'x' is normalised to unit power
    e(:,i)= e(:,i)*std;     %rescale error back to what t would be if 'x' was not normalised    
   
    %coeff_err = ||a1-w||^2 at each timestep n, for each i samplefunctions.
    coef_err(i,:)=(a1(1,2) - -a(1,:)).*(a1(1,2) - -a(1,:))  +  (a1(1,3) - -a(2,:)).*(a1(1,3) - -a(2,:));
 
end

toc                     %measures perfomance of each algorthim in terms of runtime. (time between tic and toc)

mce = mean(coef_err, 1);        %The evolution of ||b1-w||^2 averaged over 1000 samplesfunctions (MCE)
mse = mean((abs(e).*abs(e)),2); %The evolution of mean squared error averaged over 1000 samplefunction simulations


figure(1); clf; subplot(1,2,1);
plot(10*log10(mce))
title('MSCE')
subplot(1,2,2);
plot(10*log10(mse))
title('MSE')