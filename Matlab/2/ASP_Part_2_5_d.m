load RRI_r_e.mat %load both emads and raweeds data

o=20;       %max order
p=[1:o];    %Model orders

%1)_PACF________________________________________________________________________

PACF_1=[]; %will store store partial ACF for trial 1
for i=1:o,
    
    [a,e1(i)]=aryule(detrend(RRI_trial_1_e),i);
    PACF_1=[PACF_1;-a(1,i+1)];
    
end


PACF_2=[]; %will store store partial ACF for trial 2
for i=1:o,
    
    [a,e2(i)]=aryule(detrend(RRI_trial_2_r),i);
    PACF_2=[PACF_2;-a(1,i+1)];
    
end


PACF_3=[]; %will store store partial ACF for trial 3
for i=1:o,
    
    [a,e3(i)]=aryule(detrend(RRI_trial_3_e),i);
    PACF_3=[PACF_3;-a(1,i+1)];
    
end

figure(1)
hold on
stem(PACF_1, 'filled', 'black')
stem(PACF_2, 'filled', 'blue')
stem(PACF_3, 'filled', 'red')
legend('Trial 1','Trial 2','Trial 3', 'location', 'northeast')


%95% confidence interval assuming sample length 440, even though trial 2
%is 580 long. this is just for simplicity on the graph.
conf = 1.96/sqrt(440); 
plot([1,o],[conf conf],'r--', [1,o],[-conf -conf],'r--')
hold off

title(['Partial ACF for ECG data'])
xlabel('Correlation lag')
ylabel('PACF')

%2)_MDL,AIC______________________________________________________________________
figure(2)
%trial 1
N=length(RRI_trial_1_e);
MDL1=log10(e1)+p.*(log10(N)/N);
AIC1=log10(e1)+p.*(2/N);

%trial 2
N=length(RRI_trial_2_r);
MDL2=log10(e2)+p.*(log10(N)/N);
AIC2=log10(e2)+p.*(2/N);

%trial 2
N=length(RRI_trial_3_e);
MDL3=log10(e3)+p.*(log10(N)/N);
AIC3=log10(e3)+p.*(2/N);

plot(p,MDL1, p, MDL2+0.5, p, MDL3, p, AIC1, p, AIC2+0.5, p, AIC3)
legend('MDL, trial 1', 'MDL, trial 2', 'MDL, trial 3', 'AIC, trial 1', 'AIC, trial 2', 'AIC, trial 3')
title('MDL and AIC for the three trials')
xlabel('Model order p')
ylabel('Cumulative square error')
ylim([-4.6, -2.8])




