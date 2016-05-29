%this script plots the MSE and PG for all the recordings at both sample
%rates for different model orders.
clc;clear;

load voice.mat;     %load recordings at both sample rates    
u=1;                %prediction gain

N=1000;             %number of samples to use from recording
of2=5000;           %starting location from recording to take samples from (44.1Khz recordings)
of1=1000;           %starting point for for 16Khz data

%1000 length sample recordings 
a16_1=a16(of1:N+of1);
e16_1=e16(of1:N+of1);
s16_1=s16(of1:N+of1);
t16_1=t16(of1:N+of1);
x16_1=x16(of1:N+of1);

a44_1=a44(of2:N+of2);
e44_1=e44(of2:N+of2);
s44_1=s44(of2:N+of2);
t44_1=t44(of2:N+of2);
x44_1=x44(of2:N+of2);



for i=1:75,
    
    %16Khz recordings
    [ y, e, a ] = lmsAR( a16_1, u, i ); %Normalised LMS
    pg_a16(i,1)=10*log10(1/var(e));   %prediction gain
    mse_a16(i,1)=mean(e.*e);          %mean square error
    
    [ y, e, a ] = lmsAR( e16_1, u, i ); %Normalised LMS
    pg_e16(i,1)=10*log10(1/var(e));   %prediction gain
    mse_e16(i,1)=mean(e.*e);          %mean square error
    
    [ y, e, a ] = lmsAR( s16_1, u, i ); %Normalised LMS
    pg_s16(i,1)=10*log10(1/var(e));   %prediction gain
    mse_s16(i,1)=mean(e.*e);          %mean square error
    
    [ y, e, a ] = lmsAR( t16_1, u, i ); %Normalised LMS
    pg_t16(i,1)=10*log10(1/var(e));   %prediction gain
    mse_t16(i,1)=mean(e.*e);          %mean square error
    
    [ y, e, a ] = lmsAR( x16_1, u, i ); %Normalised LMS
    pg_x16(i,1)=10*log10(1/var(e));   %prediction gain
    mse_x16(i,1)=mean(e.*e);          %mean square error
    
   
    %44.1Khz recordings
    [ y, e, a ] = lmsAR( a44_1, u, i ); %Normalised LMS
    pg_a44(i,1)=10*log10(1/var(e));   %prediction gain
    mse_a44(i,1)=mean(e.*e);          %mean square error
    
    [ y, e, a ] = lmsAR( e44_1, u, i ); %Normalised LMS
    pg_e44(i,1)=10*log10(1/var(e));   %prediction gain
    mse_e44(i,1)=mean(e.*e);          %mean square error
    
    [ y, e, a ] = lmsAR( s44_1, u, i ); %Normalised LMS
    pg_s44(i,1)=10*log10(1/var(e));   %prediction gain
    mse_s44(i,1)=mean(e.*e);          %mean square error
    
    [ y, e, a ] = lmsAR( t44_1, u, i ); %Normalised LMS
    pg_t44(i,1)=10*log10(1/var(e));   %prediction gain
    mse_t44(i,1)=mean(e.*e);          %mean square error
    
    [ y, e, a ] = lmsAR( x44_1, u, i ); %Normalised LMS
    pg_x44(i,1)=10*log10(1/var(e));   %prediction gain
    mse_x44(i,1)=mean(e.*e);          %mean square error
    
end

p=[1:75];
figure(1)
plot(p, log(mse_a16), p, log(mse_e16), p, log(mse_s16), p, log(mse_t16), p, log(mse_x16), p, log(mse_a44), p, log(mse_e44), p, log(mse_s44), p, log(mse_t44), p, log(mse_x44) );
legend('a16','e16','s16','t16','x16','a44.1','e44.1','s44.1','t44.1','x44.1')
title('MSE vs model order for both sample rates')
xlabel('Model order p')
ylabel( 'log10 (MSE)' )

figure(2)
plot(p, (pg_a16), p, (pg_e16), p, (pg_s16), p, (pg_t16), p, (pg_x16), p, (pg_a44), p, (pg_e44), p, (pg_s44), p, (pg_t44), p, (pg_x44));
legend('a16','e16','s16','t16','x16','a44.1','e44.1','s44.1','t44.1','x44.1')
title('PG vs model order for both sample rates')
xlabel('Model order p')
ylabel( 'PG' )


