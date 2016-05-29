function [ y, e, w ] = nlms( x, z, u, q )
% Adaptive filter that approximates the Wiener solution in a recursive
% fashion.
%
%Inputs:
%
% x = input vector of length of N
% z = realistic (noisy) measured output of system to model of length N
% u = adaption gain
% q = adaptive filter order .(number of co-eff is order+1)
%
%Output:
%
% y = LMS estimate of length N
% e = error vector [n] = z[n] - y[n] 
% w = (p+1) * N matrix containing evolution of adaptive weights over time

ep=1e-20;           %small regularisation constant to avoid division by zero for small input values.
N=length(x);        %length of input vector.
w=zeros(q+1,1);     %starting point for estimate

for n=1:N-1,
    
    xp=xpast(x,n,q);    %xp = (q) past values of x starting from x[n] = current value. (column vector)
    y(n,1)= xp'*w(:,n); %estimated output
    e(n,1)=z(n)-y(n,1); %error in estimation of output
   
    %Normalise u to power of signal power in filter memory
    u_n=u/((xp'*xp)+ep);
    
    w(:,n+1) = w(:,n) + u_n*e(n)*xp; %update filter weights

end

end