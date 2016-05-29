%clc;clear;clf;
load voice.mat;             %the voice recordings at both sample frequencies, 44.1, and 16khz.

of=3000;                    %offset to start from (the recordings are zero for a while)
N=1000;                     %number of input samples 

p=3;                        %AR process order;
u=1;                        %adaptation gain

x=[];
x=s44(1+of: of+N);

[ y, e, a ] = lmsAR( x, u, p ); %Normalised LMS

%plot coeficents evolution
figure(1); clf;
subplot(1,3,1)
plot(a')
title('Evolution of weights')
xlabel('Time [samples]')
ylabel('Weights')

%plot prediction and input
subplot(1,3,2)
hold on
plot(x);
plot( y, 'r');
legend('Input', 'Prediction')
hold off
title('Prediction')
xlabel('Time [samples]')
ylabel('Amplitude')

%plot error
subplot(1,3,3)
plot(e)
title('Prediction error')
xlabel('Time [samples]')
ylabel('Amplitude')

%peformance measures
PG=10*log10(1/var(e))   %prediction gain
MSE=mean(e.*e)          %mean square error

p=audioplayer(y,44100); %listeing to prediction
play(p)


%order selection, MDL/AIC
e=[];
o=20;       %max order
p=[1:o];    %Model orders

for i=1:o   %obtaining ccumulated square error for different orders
    [a,e(i)]= aryule(x,i);
end

MDL=log10(e)+p.*(log10(N)/N);
AIC=log10(e)+p.*(2/N);
figure(2)
plot(p,MDL, p, AIC)
title(['MDL,AIC for "s" sound'])
xlabel('Model order p')
ylabel('MDL,AIC')
legend('MDL','AIC','Location','northeast');


