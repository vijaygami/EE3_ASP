clc;clear;
load vinyl.mat

N=length(um);   %length of audio
p=[100,450];    %filter order, [channel 1, channel 2]
u=1;          %adaptation gain (1.5 best for both channels)
c=1;            %channel to filter




for c=1:2,  %filter both channels
    [denoised_um(:,c), e ] = denoise(um(:,c), um_original(:,c) ,u, p(1,c) );
    [denoised_um(:,c), e ] = denoise(um(:,c), um_original(:,c) ,u, p(1,c) );
end


pa=audioplayer(denoised_um, FS);
play (pa);

%save the results. they are analysed in 'ASP_Part_6b.mat'
save('denoised_um.mat', 'denoised_um'); 
