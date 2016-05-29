function [ yest, e ] = denoise( x, y, u, p)
% Adaptive denoiser that minimises error between clean and filtered noisy
% using the NLMS algorithm
%
%Inputs:
%
% x = noisy signal vector of length of N
% y = clean teaching signal
% u = adaption gain
% p = adaptive filter order .(number of co-eff is order+1)
%
%Output:
%
% y = de noised signal
% e = error vector [n] = y[n] - yest[n] 
% w = (p+1) * N matrix containing evolution of adaptive weights over time.(temporarily removed for memory saving)

ep=1e-20;           %small regularisation constant to avoid division by zero for small input values.
N=length(x);        %length of input vector.

w=zeros(p+1,1);     %starting point for estimate
%w=zeros(p+1,N-1);  %prealocate memory for speed. used in the case where coefficient history is stored (for report purposes)
umax=1;             %max step 
est=0;              %estimated min MSE. 
k=0.9;              %Time consnatnt.             
e_s=0;              %intial value

yest=zeros(N-1,1);  %prealocate memory for speed
e=zeros(N-1,1);

for n=1:N-1,
    
    xp=xpast(x,n,p);          %xp = (p-1) past values of x starting x[n]. (column vector)
    yest(n,1)= xp'*w(:,1);    %estimated output (denoised signal). (use w(:,n) if weigh history is to be stored)
    e(n,1)=y(n)-yest(n,1);    %error in estimation of output
    
    e_s=(1-k)*e(n,1) + k*e_s; %smooth error with IIR 1sit order filter
    
    u_n=(u*abs((abs(e_s) - est)))*1000;  %learning step is proportional to (absolute error - estimated minimum error) 
    
    if(u_n>umax), u_n=umax;   %upper limit on step size for stability
    end
   
    u_n=u_n/((xp'*xp)+ep);    %Normalise u to power of signal power in filter memory
    
    w(:,1) = w(:,1) + u_n*e_s*xp; %update filter weights
   % w(:,n+1) = w(:,n) + u_n*e_s*xp; %(use this line instead if weigh history is to be stored
end
    
end

