N=1000;   %sample number
M=1000;   %ensemlbe sample size

%(Q1 for rp1)_______________________________________________________________________
d1=rp1(M,N);

%ensemble mean and std dev and plotting
m1=mean(d1,1);
s1=std(d1,0,1);

figure (1);
subplot(1,3,1)
o=errorbar(m1,s1);
h_c = get(o, 'children');   % handle to the errorbar object, used to change colours
set(h_c(1),'color','blue'); % data colour set
set(h_c(2),'color','red');  % error bars colour set
title('rp1 mean and standard deviation')
xlabel('Time Index')
ylabel('Amplitude')
xlim([0 N])

%(Q1 for rp2)_______________________________________________________________________

d2=rp2(M,N);

%ensemble mean and std dev and plotting
m2=mean(d2,1);
s2=std(d2,0,1);

subplot(1,3,2)
o=errorbar(m2,s2);
h_c = get(o, 'Children');   % handle to the errorbar object, used to change colours
set(h_c(1),'color','blue'); % data colour set
set(h_c(2),'color','red');  % error bars colour set
title('rp2 mean and standard deviation')
xlabel('Time Index')
ylabel('Amplitude')
xlim([0 N])

%(Q1 for rp3)_______________________________________________________________________

d3=rp3(M,N);

%ensemble mean and std dev and plotting
m3=mean(d3,1);
s3=std(d3,0,1);

subplot(1,3,3)
o=errorbar(m3,s3);
h_c = get(o, 'Children');   % handle to the errorbar object, used to change colours
set(h_c(1),'color','blue'); % data colour set
set(h_c(2),'color','red');  % error bars colour set
title('rp3 mean and standard deviation')
xlabel('Time Index')
ylabel('Amplitude')
xlim([0 N])


%___________________________________________________________________________________
%plottting ensamble variance against time and comparing to
%theoretical values as caluclated in part 1.2.3
figure (2);
subplot(2,3,1)
var1=var(d1,0,1);
plot(var1);
title('rp1 variance')
xlabel('Time Index')
ylabel('Variance')
hold on     %adding theoretical ensamble variance to plot
x=[1:N];     
y=(25/12).*(sin(x*pi/N).^2);    
plot(x,y, 'red')
hold off

subplot(2,3,2)
var2=var(d2,0,1);
plot(var2);
title('rp2 variance')
xlabel('Time Index')
ylabel('Variance')
hold on     %adding theoretical ensamble variance to plot
plot([1,N],[1/9,1/9], 'red')
hold off
ylim([0, 1])

subplot(2,3,3)
var3=var(d3,0,1);
plot(var3);
title('rp3 variance')
xlabel('Time Index')
ylabel('Variance')
hold on     %adding theoretical ensamble variance to plot
plot([1,N],[0.75,0.75], 'red')
hold off
ylim([0, 1])
ylim([0 1])


%plottting ensamble mean against time and comparing to
%theoretical values as caluclated in part 1.2.3
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
plot([1,N],[0.5,0.5], 'red')
hold off
ylim([0, 1])

subplot(2,3,6)
m3=mean(d3,1);
plot(m3);
title('rp2 mean')
xlabel('Time Index')
ylabel('Mean')
hold on     %adding theoretical ensamble variance to plot
plot([1,N],[0.5,0.5], 'red')
hold off
ylim([0, 1])









