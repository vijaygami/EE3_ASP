function [ y, e, w] = nlms_gear2( x, z, u, q )
% Adaptive filter that approximates the Wiener solution in a recursive
% fashion.
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


ep=1e-20;               %small regularisation constant to avoid division by zero for small input values.
N=size(x); N=N(1,1);    %length of input vector.
w=zeros(q+1,1);         %starting point for estimate
umax=1;                 %max step (pre normalised) for staability
est=0.01;               %estimated minimum MSE. set to zero if unknown

k=0.93;                 %consnat used to adjust time averaging of error via first order recursive filter: k=e^(-1/(time_constant*sample_freq))
e_s=1;                  %initialvalue for recursive filter

for n=1:N-1,
    
    xp=xpast(x,n,q);    %xp = (q) past values of x starting from x[n] = current value. (column vector)
    y(n,1)= xp'*w(:,n); %estimated output
    e(n,1)=z(n)-y(n,1); %error in estimation of output
   
    e_s=(1-k)*e(n,1) + k*e_s;             %smooth error with IIR recursive first order filter
 
    u_n=(u*abs((abs(e_s) - est)))*100;    %learning step is proportional to (absolute error - estimated minimum error) 
   
    
    %4 distinct 'gears'
    if(e_s*e_s < 20*est)
        u_n=(u*   abs(e_s*e_s-est)     )*50;        
    end
    
    if(e_s*e_s < 5*est)
        u_n=(u*   abs(e_s*e_s-est)     )*25;
    end
    
    if(e_s*e_s < 1*est)
        u_n=(u*   abs(e_s*e_s-est)     )*10;
    end
    if(e_s*e_s < 0.2*est)
        u_n=(u*   abs(e_s*e_s-est)     )*2;
    end


    

    if(u_n>umax), u_n=umax; %upper limit on step size for stability
    end
    
    u_n=u_n/((xp'*xp)+ep);  %nlms: normalise u to signal power in filter memory

    w(:,n+1) = w(:,n) + u_n*e(n)*xp; %update filter weights

end


end

