function [ y, e, a ] = lmsAR( x, u, p )
% Adaptive filter that adaptivley identifies AR system in a recursive
% fashion.
%
%Inputs:
%
% x = input vector with lenght of N
% u = adaption gain
% p = adaptive filter order .(number of co-eff is order+1)
%
%Output:
%
% y = predictor output
% e = error vector [n] = x[n] - y[n] 
% a = (p) * N matrix containing evolution of adaptive weights over time,
%  it does not include a0 which is 1.

N=length(x);            %length of input vector.
a=zeros(p,1);           %starting point for estimate
ep=1e-20;           %small regularisation constant to avoid division by zero for small input values.

for n=1:N-1,
    
    xp = xpast(x,n-1,p-1);        %xp = (p) past outputs of x, NOT including  x[n], hence i-1, p-1 inputted. (column vector)
    
    y(n,1) = xp'*a(:,n);          %estimated output
    
    e(n,1) = x(n)-y(n,1);         %error in estimation of output
    
    u_n=u/((xp'*xp)+ep);          %normalise to power in filter memory

    a(:,n+1) = a(:,n)  + u_n*e(n)*xp; %update all filter weights excluding the first weight. 

end


end

