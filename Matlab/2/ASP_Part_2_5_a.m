%{
%RRI data extraction%

%raweed data
N=145e3;
a=8.5e4;
b=2.61e5;
c=5.2e5;
ECG_Raweed = [data(a:a+N-1), data(b:b+N-1), data(c:c+N-1)];

%emad data
N=1.1e5;
a=1e5;
b=2.7e5;
c=5.7e5;
ECG_Emad = [data(a:a+N-1), data(b:b+N-1), data(c:c+N-1)];

[RRI_trial_1,fs_RRI] = ECG_to_RRI(ECG_Emad(:,1),fs);
[RRI_trial_2,fs_RRI] = ECG_to_RRI(ECG_Emad(:,2),fs);
[RRI_trial_3,fs_RRI] = ECG_to_RRI(ECG_Emad(:,3),fs);
%}

load trial_1_longer.mat
%heart rate, %fs_RRI=4.
%using a separate longer trial 1 for better pdf results
h=60./RRI_trial_1_l; 

%smoother estimate of heart rate by averageing over 10 samples, a=1
s=size(RRI_trial_1_l); s=s(1,2);

a=1;
for i=1:(s-9)/10
    
    h1(i)=a*sum(h(1+10*i:10*i+10))/10;

end


%smoother estimate of heart rate by averageing over 10 samples, a=0.6
a=0.6;
for i=1:(s-9)/10
    
    h2(i)=a*sum(h(1+10*i:10*i+10))/10;

end


%smoother estimate of heart rate by averageing over 10 samples, a=0.6,
%remove bias by dividing by 6 rather than 10.
a=0.6;
for i=1:(s-9)/10
    
    h3(i)=a*sum(h(1+10*i:10*i+10))/6;

end

%plotting the original data and smoothed data to compare
figure(1)
hold on
plot([1:s]/4 , h, 'LineWidth', 2)
plot([1:(s-9)/10]*10/4, h1, 'r', 'LineWidth', 2)
hold off
title('Heart rate: unconstrained breathing')
xlabel('Time / Seconds')
ylabel('Heart Rate')
legend('Original','Averaged every 10 samples','Location','northeast');
xlim([0,417])

%PDF estimate for the heart rates
bins=10;

figure(2)
subplot(1,4,1)
pdf(h, bins)
axis([ 35, 115, 0, 0.105])
title('Original heart rate PDF estimate')
xlabel('Heart Rate')
ylabel('Normalised count')

subplot(1,4,2)
pdf(h1, bins)
axis([ 35, 115, 0, 0.105])
title('Averaged heart rate PDF estimate, a=1, unbiased estimator')
xlabel('Heart Rate')
ylabel('Normalised count')

subplot(1,4,3)
pdf(h2, bins)
axis([ 35, 115, 0, 0.105])
title('Averaged heart rate PDF estimate, a=0.6, biased estimator')
xlabel('Heart Rate')
ylabel('Normalised count')

subplot(1,4,4)
pdf(h3, bins)
axis([ 35, 115, 0, 0.105])
title('Averaged heart rate PDF estimate, a=0.6, unbiased estimator')
xlabel('Heart Rate')
ylabel('Normalised count')

%means and variances of the various estimates
mean_hr =[mean(h);mean(h1); mean(h2);mean(h3)]
var_hr=[var(h);var(h1); var(h2); var(h3)]