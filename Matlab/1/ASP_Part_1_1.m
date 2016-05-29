%(1) and (2)_______________________________________________________________
x = rand(1000,1);
plot(x)
m=mean(x)      %sample mean
o=std(x, 0)    %sample standard deviation

%(3)_______________________________________________________________________
x_10 = rand(10,1000);
m_10 = mean(x_10, 2);
o_10 = std(x_10, 0, 2);
bins = 5;          %number of bins for histograms

figure (1); subplot(1,2,1)
hist(m_10, bins)
title('Distribution of sample means for uniform distribution')
xlabel('Sample mean')
ylabel('Count')

subplot(1,2,2)
hist(o_10, bins); 
title('Distribution of sample std.dev. for uniform distribution')
xlabel('Sample standard deviation')
ylabel('Count')


%showing the theoretical mean and std.dev as a green stem
% and the the mean of the 10 calculated sample means and std.devs
% as a red stem on the same graphs
subplot(1,2,1)
hold on
stem(0.5,3, 'green')
stem(mean(m_10),3, 'red')
hold off

subplot(1,2,2)
hold on
stem(sqrt(1/12),3, 'green')
stem(mean(o_10),3, 'red')
hold off

%(4)_______________________________________________________________________
s=100000;        %sample number
bins = 10;      %no. of bins
x = rand(s,1);

figure (2);
[c,x] = hist(x, bins);
area=sum(c)*(x(1,2)-x(1,1)); %area of histogram
bar(x,c/area); %divide by area to normalise histogram to aproximate PDF

%plotting the theoretical uniform disribution on the same graph to compare
hold on
stairs([-0.1 0 1 1.1],[0 1 0 0],'red', 'LineWidth', 2)
hold off

title('Area normalised histogram aproximating PDF')
xlabel('x')
xlim([-0.1, 1.1])
ylabel('normalised count')

