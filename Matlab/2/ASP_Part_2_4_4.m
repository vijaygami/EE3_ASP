load sunspot.dat
N=size(sunspot); N=N(1,1); %number of samples in sunspot

e=[];
o=20;       %max order
p=[1:o];    %Model orders

for i=1:o   %obtaining ccumulated square error for different orders
    [a,e(i)]= aryule(sunspot(:,2),i);
end

MDL=log10(e)+p.*(log10(N)/N);
AIC=log10(e)+p.*(2/N);




%repeating for standardised data
sunspot(:,2)=sunspot(:,2)-mean(sunspot(:,2));           %zero mean
sunspot(:,2)=sunspot(:,2)./sqrt(var(sunspot(:,2), 0));  %unit variance

e_s=[];
for i=1:o   %obtaining cumulated square error for different orders
    [a,e_s(i)]= aryule(sunspot(:,2),i);
end

MDL_s=log10(e_s)+p.*(log10(N)/N);
AIC_s=log10(e_s)+p.*(2/N);




%plotting the results
subplot(2,2,1)
plot(p, MDL, 'blue', p, AIC, 'black')
title(['MDL,AIC for sunspot data'])
xlabel('Model order p')
ylabel('MDL,AIC')
legend('MDL','AIC','Location','northeast');

subplot(2,2,3)
plot(p, e, 'red')
title('Cumulative square error for sunspot data')
xlabel('Model order p')
ylabel('Cumulative square error')


subplot(2,2,2)
plot(p, MDL_s, 'blue', p, AIC_s, 'black')
title(['MDL,AIC for standardised sunspot data'])
xlabel('Model order p')
ylabel('MDL,AIC')
legend('MDL','AIC', 'Location','northeast');

subplot(2,2,4)
plot(p, e_s, 'red')
title('Cumulative square error for standardised sunspot data')
xlabel('Model order p')
ylabel('Cumulative square error')



