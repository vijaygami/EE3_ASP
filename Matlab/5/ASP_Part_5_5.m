clc;clear;
load vinyl.mat

N=1345050;  %length of audio
p=[100,450];  %filter order, [channel 1, channel 2]
u=0.01;      %adaptation gain (1.5 best for both channels)
c=1;        %channel to filter

for c=1:2,  %filter both cchannels
    [denoised(:,c), e ] = denoise(s2h(:,c), s2h_original(:,c) ,u, p(1,c) );
    [denoised(:,c), e ] = denoise(s2h(:,c), s2h_original(:,c) ,u, p(1,c) );
end

%save the results. they are analysed in 'ASP_Part_5b.mat'
save('denoised.mat', 'denoised'); 
