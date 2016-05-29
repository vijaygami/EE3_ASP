function [ y, e, w ] = lms( x, z, u, q )
% Adaptive filter that approximates the Wiener solution in a recursive
% fashion.
%
%Inputs:
%
% x = input vector with lenght of N
% z = realistic (noisy) measured output of system to model. length N
% u = adaption gain
% q = adaptive filter order .(number of co-eff is order+1)
%
%Output:
%
% y = LMS estimate of length N
% e = error vector [n] = z[n] - y[n] 
% w = (p+1) * N matrix containing evolution of adaptive weights over time


N=length(x);    %length of input vector.
w=zeros(q+1,1);         %starting point for estimate

for n=1:N-1,
    
    xp=xpast(x,n,q);    %xp = (q) past values of x starting from x[n] = current value. (column vector)
    y(n,1)= xp'*w(:,n); %estimated output
    e(n,1)=z(n)-y(n,1); %error in estimation of output
    
    w(:,n+1) = w(:,n) + u*e(n)*xp; %update filter weights

end

end

