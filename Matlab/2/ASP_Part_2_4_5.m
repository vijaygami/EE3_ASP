clc;clear;
load sunspot.dat
sunspot(:,2)=sunspot(:,2)-mean(sunspot(:,2));           %zero mean
sunspot(:,2)=sunspot(:,2)./sqrt(var(sunspot(:,2), 0));  %unit varianc
sun=sunspot(:,2);                                        %shorter name for simplicity


%AR Models of different orders.
a1= aryule(sunspot(:,2),1);     %Model order 1
a2= aryule(sunspot(:,2),2);     %Model order 2
a10= aryule(sunspot(:,2),10);   %Model order 10

s=20;        %start point for predictions (must be greater than 9)
pr=60;       %number of predictions to make
ph=1;       %prediction horizon. 1 -> 10

x= s : (pr+s-1);   %x-axis used for plots



%generating the predictions using AR(1), AR(2), and AR(10) models.
%to predict future samples, first the next step is predicted. This 
%prediction is then used to predict the second step and so on.

for i = 1 : pr %AR(1)
    s1_10(i,1)=-a1(1,2)*sun(s+i);       %predicting next sample    
    s1_10(i,2)=-a1(1,2)*s1_10(i,1);     %predincting 2 samples ahead using previous estimate
    s1_10(i,3)=-a1(1,2)*s1_10(i,2);     %predicting 3 samples ahead using previous estimates
    s1_10(i,4)=-a1(1,2)*s1_10(i,3);     %and so on....
    s1_10(i,5)=-a1(1,2)*s1_10(i,4);
    s1_10(i,6)=-a1(1,2)*s1_10(i,5);
    s1_10(i,7)=-a1(1,2)*s1_10(i,6);
    s1_10(i,8)=-a1(1,2)*s1_10(i,7);
    s1_10(i,9)=-a1(1,2)*s1_10(i,8);
    s1_10(i,10)=-a1(1,2)*s1_10(i,9);
end


for i = 1 : pr %AR(2)
    s2_10(i,1)=-a2(1,2)*sun(s+i)  -a2(1,3)*sun(s+i-1);
    s2_10(i,2)=-a2(1,2)*s2_10(i,1)  -a2(1,3)*sun(s+i);
    s2_10(i,3)=-a2(1,2)*s2_10(i,2)  -a2(1,3)*s2_10(i,1);
    s2_10(i,4)=-a2(1,2)*s2_10(i,3)  -a2(1,3)*s2_10(i,2);
    s2_10(i,5)=-a2(1,2)*s2_10(i,4)  -a2(1,3)*s2_10(i,3);
    s2_10(i,6)=-a2(1,2)*s2_10(i,5)  -a2(1,3)*s2_10(i,4);
    s2_10(i,7)=-a2(1,2)*s2_10(i,6)  -a2(1,3)*s2_10(i,5);
    s2_10(i,8)=-a2(1,2)*s2_10(i,7)  -a2(1,3)*s2_10(i,6);
    s2_10(i,9)=-a2(1,2)*s2_10(i,8)  -a2(1,3)*s2_10(i,7);
    s2_10(i,10)=-a2(1,2)*s2_10(i,9)  -a2(1,3)*s2_10(i,8);
end


for i = 1 : pr %AR(10)
    s10_10(i,1)=-a10(1,2)*sun(s+i)  -a10(1,3)*sun(s+i-1) -a10(1,4)*sun(s+i-2) -a10(1,5)*sun(s+i-3) -a10(1,6)*sun(s+i-4) -a10(1,7)*sun(s+i-5) -a10(1,8)*sun(s+i-6) -a10(1,9)*sun(s+i-7) -a10(1,10)*sun(s+i-8) -a10(1,11)*sun(s+i-9);
    s10_10(i,2)=-a10(1,2)*s10_10(i,1)  -a10(1,3)*sun(s+i) -a10(1,4)*sun(s+i-1) -a10(1,5)*sun(s+i-2) -a10(1,6)*sun(s+i-3) -a10(1,7)*sun(s+i-4) -a10(1,8)*sun(s+i-5) -a10(1,9)*sun(s+i-6) -a10(1,10)*sun(s+i-7) -a10(1,11)*sun(s+i-8);
    s10_10(i,3)=-a10(1,2)*s10_10(i,2)  -a10(1,3)*s10_10(i,1) -a10(1,4)*sun(s+i) -a10(1,5)*sun(s+i-1) -a10(1,6)*sun(s+i-2) -a10(1,7)*sun(s+i-3) -a10(1,8)*sun(s+i-4) -a10(1,9)*sun(s+i-5) -a10(1,10)*sun(s+i-6) -a10(1,11)*sun(s+i-7);
    s10_10(i,4)=-a10(1,2)*s10_10(i,3)  -a10(1,3)*s10_10(i,2) -a10(1,4)*s10_10(i,1) -a10(1,5)*sun(s+i) -a10(1,6)*sun(s+i-1) -a10(1,7)*sun(s+i-2) -a10(1,8)*sun(s+i-3) -a10(1,9)*sun(s+i-4) -a10(1,10)*sun(s+i-5) -a10(1,11)*sun(s+i-6);
    s10_10(i,5)=-a10(1,2)*s10_10(i,4)  -a10(1,3)*s10_10(i,3) -a10(1,4)*s10_10(i,2) -a10(1,5)*s10_10(i,1) -a10(1,6)*sun(s+i) -a10(1,7)*sun(s+i-1) -a10(1,8)*sun(s+i-2) -a10(1,9)*sun(s+i-3) -a10(1,10)*sun(s+i-4) -a10(1,11)*sun(s+i-5);
    s10_10(i,6)=-a10(1,2)*s10_10(i,5)  -a10(1,3)*s10_10(i,4) -a10(1,4)*s10_10(i,3) -a10(1,5)*s10_10(i,2) -a10(1,6)*s10_10(i,1) -a10(1,7)*sun(s+i) -a10(1,8)*sun(s+i-1) -a10(1,9)*sun(s+i-2) -a10(1,10)*sun(s+i-3) -a10(1,11)*sun(s+i-4);
    s10_10(i,7)=-a10(1,2)*s10_10(i,6)  -a10(1,3)*s10_10(i,5) -a10(1,4)*s10_10(i,4) -a10(1,5)*s10_10(i,3) -a10(1,6)*s10_10(i,2) -a10(1,7)*s10_10(i,1) -a10(1,8)*sun(s+i) -a10(1,9)*sun(s+i-1) -a10(1,10)*sun(s+i-2) -a10(1,11)*sun(s+i-3);
    s10_10(i,8)=-a10(1,2)*s10_10(i,7)  -a10(1,3)*s10_10(i,6) -a10(1,4)*s10_10(i,5) -a10(1,5)*s10_10(i,4) -a10(1,6)*s10_10(i,3) -a10(1,7)*s10_10(i,2) -a10(1,8)*s10_10(i,1) -a10(1,9)*sun(s+i) -a10(1,10)*sun(s+i-1) -a10(1,11)*sun(s+i-2);
    s10_10(i,9)=-a10(1,2)*s10_10(i,8)  -a10(1,3)*s10_10(i,7) -a10(1,4)*s10_10(i,6) -a10(1,5)*s10_10(i,5) -a10(1,6)*s10_10(i,4) -a10(1,7)*s10_10(i,3) -a10(1,8)*s10_10(i,2) -a10(1,9)*s10_10(i,1) -a10(1,10)*sun(s+i) -a10(1,11)*sun(s+i-1);
    s10_10(i,10)=-a10(1,2)*s10_10(i,9)  -a10(1,3)*s10_10(i,8) -a10(1,4)*s10_10(i,7) -a10(1,5)*s10_10(i,6) -a10(1,6)*s10_10(i,5) -a10(1,7)*s10_10(i,4) -a10(1,8)*s10_10(i,3) -a10(1,9)*s10_10(i,2) -a10(1,10)*s10_10(i,1) -a10(1,11)*sun(s+i);

end

%plotting the predictions and comparing to the actual sunspot data

figure(1); clf;
hold on
plot(x, s1_10(:,ph), x,  s2_10(:,ph), x, s10_10(:,ph), 'LineWidth', 2)
plot(x, sun(s+ph:pr+s+ph-1),'black',  'LineWidth', 3)
hold off
legend('P=1', 'P=2', 'P=10', 'Original Data', 'Location', 'NorthWest' )
title(['Prediction Horizon:' num2str(ph)])
xlabel('Time index, [years]')
ylabel('Normalised sunspot count')

ylim([-1.5, 3.5])






