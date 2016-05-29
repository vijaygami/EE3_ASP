function [ y, e, a ] = lms_sign( x, u, p, s )
% Adaptive filter that adaptivley identifies AR system in a recursive
% fashion.
%
%Inputs:
%
% x = input vector with lenght of N
% u = adaption gain
% p = adaptive filter order .(number of co-eff is order+1)
% S = 0,1,2 or 3. see 'Software switches' section below. 
%
%Output:
%
% y = predictor output
% e = error vector [n] = x[n] - y[n] 
% a = (p) * N matrix containing evolution of adaptive weights over time,
%  it does not include a0 which is 1.
%
%Software Switches:
% the fourth input is a switch: (default is 0)
%
%       set to 0 for default algorithm
%       set to 1 for signed - error (sign algorithm)
%       set to 2 for signed - regresor
%       set to 3 for sign - sign


N=length(x);            %length of input vector.
a=zeros(p,1);           %starting point for estimate

for n=1:N-1,
    
    xp = xpast(x,n-1,p-1);        %xp = (p) past outputs of x, NOT including  x[n], hence i-1, p-1 inputted. (column vector)
    
    y(n,1) = xp'*a(:,n);          %estimated output
    
    e(n,1) = x(n)-y(n,1);         %error in estimation of output

    %update all filter weights excluding the first weight. 
   
    if s==1,        a(:,n+1) = a(:,n)  + u*xp*sign(e(n));
    elseif s==2,    a(:,n+1) = a(:,n)  + u*e(n)*sign(xp);
    elseif s==3,    a(:,n+1) = a(:,n)  + u*e(n)*xp;
    else            a(:,n+1) = a(:,n)  + u*sign(e(n))*sign(xp); %default original lms algorithm for AR parameter identification
    end
              
end

end

