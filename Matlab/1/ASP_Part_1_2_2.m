N=1000; %sample number
M=4;    %ensemlbe sample size

d1=rp1(M,N); 
d2=rp2(M,N);
d3=rp3(M,N);

%calculating temporal statistics
m1_time=mean(d1,2);
s1_time=std(d1,0,2);
var1_time=var(d1,0,2);

m2_time=mean(d2,2);
s2_time=std(d2,0,2);
var2_time=var(d2,0,2);

m3_time=mean(d3,2);
s3_time=std(d3,0,2);
var3_time=var(d3,0,2);























