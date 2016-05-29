%pgm function withount using fft function

%{
function [pxx]= pgm(x);
%Input: column vector of N input samples, Output: pxx = PSD estimate at N frequencies

N=length(x);           %size of input vector

for k=0:N-1,   
  
    %matlab indexes must start from 1 so offset all indexes by +1.
  
    pxx(k+1)=0;     
    for j=0:N-1,
        pxx(k+1) = pxx(k+1) + x((j+1),1)*exp(-k*j*2*pi*i/N);
    end
    
    pxx(k+1)=(pxx(k+1)*conj(pxx(k+1)))/N;
    
end

pxx=pxx';

end

%}


%faster implementation using the fft

function [pxx]= pgm(x);

N=length(x);

f=(fft(x));
pxx=(f.*conj(f))./N;
end



