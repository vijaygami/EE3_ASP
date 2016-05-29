
%(1) and (2)_______________________________________________________________
x = randn(1000,1);
plot(x)
m=mean(x)      %sample mean
o=std(x, 0)    %sample standard deviation

%(3)_______________________________________________________________________
x_10 = randn(10,1000);
m_10 = mean(x_10, 2);
o_10 = std(x_10, 0, 2);
bins = 5;     %number of bins for histogram

figure (1); subplot(1,2,1)
hist(m_10, bins)
title('Distribution of sample means for normal distribution')
xlabel('Sample mean')
ylabel('Count')

subplot(1,2,2)
hist(o_10, bins); 
title('Distribution of sample std.dev. for normal distribution')
xlabel('Sample standard deviation')
ylabel('Count')


%showing the theoretical mean and variance as a green stem and the the mean 
% of the 10 calculated sample means and std.dev. as a red stem on the same 
% graphs
subplot(1,2,1)
hold on
stem(0, 2, 'green')
stem(mean(m_10),2, 'red')
hold off

subplot(1,2,2)
hold on
stem(1 ,2, 'green')
stem(mean(o_10),2, 'red')
hold off

%(4)_______________________________________________________________________
s=1000;        %sample number
bins = 10;      %no. of bins
x = randn(s,1);

figure (2);
[c,x] = hist(x, bins);
area=sum(c)*(x(1,2)-x(1,1)); %area of histogram
bar(x,c/area); %divide by area to normalise histogram to aproximate PDF

%plotting the normal disribution on the same graph to compare
hold on
x = [-5:.05:5];
norm = normpdf(x,0,1);
plot(x,norm, 'red', 'LineWidth', 2);
hold off

title('Area normalised histogram aproximating PDF')
xlabel('x')
ylabel('normalised count')

