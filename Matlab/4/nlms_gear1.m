function [ y, e, w ] = nlms_gear1( x, z, u, q )
% Adaptive filter that approximates the Wiener solution in a recursive
% fashion. The 'gear' is linearly proportional to the error.
%
%Inputs:
%
% x = input vector lenght of N
% z = realistic (noisy) measured output of system to model of length N
% u = adaption gain
% q = adaptive filter order .(number of co-eff is order+1)
%
%Output:
%
% y = LMS estimate of length N
% e = error vector [n] = z[n] - y[n] 
% w = (p+1) * N matrix containing evolution of adaptive weights over time

ep=1e-20; %small regularisation constant to avoid division by zero for small input values.
N=size(x); N=N(1,1);    %length of input vector.
w=zeros(q+1,1);         %starting point for estimate
umax=1.5;               %max step (pre normalised) for staability

for n=1:N-1,
    
    xp=xpast(x,n,q);    %xp = (q) past values of x starting from x[n] = current value. (column vector)
    y(n,1)= xp'*w(:,n); %estimated output
    e(n,1)=z(n)-y(n,1); %error in estimation of output
    
    
    u_n=(u*abs(e(n,1)));    %learning step is proportional to absolute error.
    
    u_n=u_n/((xp'*xp)+ep);  %nlms: normalise u to signal power in filter memory
    
    if(u_n>umax), u_n=umax; %upper limit on step size for stability
    end
   
    w(:,n+1) = w(:,n) + u_n*e(n)*xp; %update filter weights

end

end

