clc;clear;clf;
rng(1)

N=5000;                 %number of input samples
p=2;                    %AR process order;
u=0.001;                 %adaptation gain

b1=[1];                 %AR model for sythesis stage
a1=[1, 0.9, 0.2];

    
n=randn(N,1);           %WGN input.
x=filter(b1,a1,n);      %output of filter
std=sqrt(var(x));
[ y, e, a ] = lmsAR( (x./std), u, p); %input 'x' is normalised to unit power
e= e*std;               %rescale error back to what t would be if 'x' was not normalised    



% Plotting the evolution of the coefficients
figure(1); clf;
col=hsv(p);     %colours for the p+1 plots
hold on
for i=1:p,
    plot( a(i,:),'color',col(i,:))
end

% Adding the ideal coefficients
plot([0, N], [-0.9, -0.9],'--', [0, N], [-0.2, -0.2], '--')


hold off
legend('a1', 'a2', 'a1 ideal', 'a2 ideal')
title(['Evolution of weights, u = ' num2str(u)])
xlabel('Time [samples]')
ylabel('Weights')


% Performance measures
PG=10*log10(1/var(e))       %Prediction gain (input x is normalised to unit varaince)
MSE=mean(e.*e)              %Average Mean square error. (should be equal to varaince of n in ideal case.)
