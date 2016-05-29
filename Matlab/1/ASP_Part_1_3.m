
%(1)_______________________________________________________________________
N=10000000;
v=randn(1,N); %single sample function of stationary process with guassian pdf
bins=1000;

figure(1)
pdf(v,bins);

%plotting the normal disribution on the same graph to compare
hold on
x = [-5:.05:5];
norm = normpdf(x,0,1);                  %normal disribution
plot(x,norm, 'red', 'LineWidth', 1.5);
hold off



%(2)_______________________________________________________________________
N=10000;
d3=rp3(1,N); %single sample function of stationary process with guassian pdf
bins=20;

figure(2)
pdf(d3,bins);

%plotting the theoretical disribution on the same graph to compare.
%theoretical distribution is D3~U(-1,2)
hold on
stairs([-3 -1 2 5],[0 1/3 0 0],'red', 'LineWidth', 2);
hold off
axis([-1.5, 2.5, 0, 0.5])



%(3)_______________________________________________________________________
%PDF of nonstationary process
figure(3)
N=500;
bins=10;

non_stat=[randn(1,N), (randn(1,N) + 1)]; %mean changes to 1 halfway
pdf(non_stat,bins);

figure(4)   %separating the data into two and estimating PDF separately
subplot(1,2,1)
pdf(non_stat(1:500),bins/2);

subplot(1,2,2)
pdf(non_stat(501:1000),bins/2);


%linearly changing mean with time.
N=50000;
bins=100;

non_stat2=randn(1,N)+[1:N]*10/N;
pdf(non_stat2(),bins);

figure(4)  %plotting PDF using shorter frames to capture 'instantaneous' PDF
subplot(1,3,1)
pdf(non_stat2(1:5000),bins/4);
title('0% to 10% of data')
axis([-5,15,0,0.5])

subplot(1,3,2)
pdf(non_stat2(15000:20000),bins/4);
title('30% to 40% of data')
axis([-5,15,0,0.5])

subplot(1,3,3)
pdf(non_stat2(45000:50000),bins/4);
title('90% to 100% of data')
axis([-5,15,0,0.5])

%plotting the theoretical disribution on the same graph to compare
%theoretical distribution is D3~U(-1,2)
%hold on
%plot([-1,2],[1/3,1/3], 'red', 'LineWidth', 2);
%hold off

