%plotting ensemble mean/variance and theoretical mean/variance to compare

N=1000;   %sample number
M=1000;   %ensemlbe sample size

d1=rp1(M,N);
d2=rp2(M,N);
d3=rp3(M,N);

%plottting ensamble variance against time and comparing to
%theoretical values as caluclated in part 1.2.3 of report
subplot(2,3,1)
var1=var(d1,0,1);
plot(var1);
title('rp1 variance')
xlabel('Time Index')
ylabel('Variance')
hold on     %adding theoretical ensamble variance to plot
x=[1:N];     
y=(25/12).*(sin(x*pi/N).^2);    
plot(x,y, 'red', 'LineWidth', 2)
hold off

subplot(2,3,2)
var2=var(d2,0,1);
plot(var2);
title('rp2 variance')
xlabel('Time Index')
ylabel('Variance')
hold on     %adding theoretical ensamble variance to plot
plot([1,N],[1/9,1/9], 'r', 'LineWidth', 2)
hold off
ylim([0, 0.2])

subplot(2,3,3)
var3=var(d3,0,1);
plot(var3);
title('rp3 variance')
xlabel('Time Index')
ylabel('Variance')
hold on     %adding theoretical ensamble variance to plot
plot([1,N],[0.75,0.75], 'red', 'LineWidth', 2)
hold off
ylim([0, 1])
ylim([0 1])


%plottting ensamble mean against time and comparing to
%theoretical values as caluclated in part 1.2.3 of report
subplot(2,3,4)
m1=mean(d1,1);
plot(m1);
title('rp1 mean')
xlabel('Time Index')
ylabel('Mean')
hold on     %adding theoretical ensamble variance to plot
x=[1:N];
y=0.02.*x;
plot(x,y, 'red')
hold off

subplot(2,3,5)
m2=mean(d2,1);
plot(m2);
title('rp2 mean')
xlabel('Time Index')
ylabel('Mean')
hold on     %adding theoretical ensamble variance to plot
plot([1,N],[0.5,0.5], 'red', 'LineWidth', 2)
hold off
ylim([0.3, 0.7])

subplot(2,3,6)
m3=mean(d3,1);
plot(m3);
title('rp2 mean')
xlabel('Time Index')
ylabel('Mean')
hold on     %adding theoretical ensamble variance to plot
plot([1,N],[0.5,0.5], 'red', 'LineWidth', 2)
hold off
ylim([0, 1])











