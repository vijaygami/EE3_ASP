%clc;clear;clf;
%this script compares the evolution of weights for the 't' recording using the sign algorithms 

load voice.mat;             %the voice recordings at both sample frequencies, 44.1, and 16khz.

N=2000;                     %number of input samples 
of=5000;                    %offset to start from (the recordings are zero for a while)
x=[];
x=t44(1+of: of+N);         
p=3;                        %AR process order;
u=0.01;                     %adaptation gain

%plotting the performance of the 3 algorithms with the same adaption
%gain
figure(1)
[ y, e, a ] = lms_sign( x, u, p, 0 );
subplot(1,4,1)
plot(a')
title('Evolution of weights, lms, u=0.01')
xlabel('Time [samples]')
ylabel('Weights')

[ y, e, a ] = lms_sign( x, u, p, 1 );
subplot(1,4,2)
plot(a')
title('Evolution of weights, sign-error, u=0.01')
xlabel('Time [samples]')
ylabel('Weights')

[ y, e, a ] = lms_sign( x, u, p, 2 );
subplot(1,4,3)
plot(a')
title('Evolution of weights, sign-regressor, u=0.01')
xlabel('Time [samples]')
ylabel('Weights')

[ y, e, a ] = lms_sign( x, u, p, 3 );
subplot(1,4,4)
plot(a')
title('Evolution of weights, sign-sign, u=0.01')
xlabel('Time [samples]')
ylabel('Weights')



%now with different adaptation gains
figure(2); clf;
[ y, e, a ] = lms_sign( x, u*100, p, 1 );
subplot(1,3,1)
plot(a')
title('Evolution of weights, sign-error, u=1')
xlabel('Time [samples]')
ylabel('Weights')

[ y, e, a ] = lms_sign( x, u*100, p, 2 );
subplot(1,3,2)
plot(a')
title('Evolution of weights, sign-regressor, u=1')
xlabel('Time [samples]')
ylabel('Weights')

[ y, e, a ] = lms_sign( x, u*10000, p, 3 );
subplot(1,3,3)
plot(a')
title('Evolution of weights, sign-sign, u=10')
xlabel('Time [samples]')
ylabel('Weights')


