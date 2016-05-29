load sunspot.dat

%{
%Partial acutocorelation 
[a,e,k] = aryule(sunspot(:,2),10);
PACF = -k;
stem(PACF)
%}


%using the yule walker equations to calculate the partial ACF up untill
% model order 15s

PACF=[]; %will store store partial ACF
for i=1:15,
    
    a=aryule(sunspot(:,2),i);
    PACF=[PACF;-a(1,i+1)];
    
end


%using the yule walker equations to calculate the partial ACF for zero mean
% and unit variance data up untill model order 10.

sunspot(:,2)=sunspot(:,2)-mean(sunspot(:,2));           %zero mean
sunspot(:,2)=sunspot(:,2)./sqrt(var(sunspot(:,2), 0));  %unit variance

PACF_n=[]; %will store partial ACF for normalised sunspot data
for i=1:15,

    a=aryule(sunspot(:,2),i);
    PACF_n=[PACF_n;-a(1,i+1)];
    
end

%comparing the PAC for the original sunspot data and normalised data
figure(1)
hold on
stem(PACF , 'filled')
stem(PACF_n, 'black', 'filled')
hold off
title(['Partial ACF for sunspot series'])
xlabel('Correlation lag')
ylabel('PACF')
legend('Sunspot PACF','Normalised sunspot PACF','Location','northeast');


%adding 95% confidence interval line to graph, assuming zero mean guassian
%distribution for PACF for lag greater than p for actual AR(p) system
hold on
conf = 1.96/sqrt(288); %1.96 because 95% of the area of guassian distribution is within 1.96 standard deviations of mean
plot([0 15],[conf conf],'r--', [0 15],[-conf -conf],'r--')
hold off



