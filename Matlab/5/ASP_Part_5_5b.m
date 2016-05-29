%Loading the data filtered by the adaptive NLMS filters. Run the script
%'ASP_Part_5_5.mat' to first generate and save the filtered data for both 
%the channels.

clc;clear;
load 'denoised.mat'
load 'vinyl.mat'
N=length(s2h);   	%length of audio
FS=44100;           %sample frequency

f=audioplayer(denoised,FS);
play(f)             %listening to result


%Channel 1 quantitative performance measures_______________________________
c=1;    %channel to cehck performance for

po=pgm(s2h_original([1:N-1],c));          
err = po - pgm(denoised(:,c));             %error is PSD of clean - PSD of filtered signal
RE_1 = sqrt( (err'*err)/(po'*po) )     %Relative Error in estimation/filtering

err =  s2h_original([1:N-1],c)-denoised(:,c) ;   %error is clean - filtered signals
PG_1=10*log10(var(s2h_original(:,c))/var(err))  %Prediction Gain performance measture



%Channel 2 quantitative performance measures_______________________________
c=2;

po=pgm(s2h_original([1:N-1],c));          
err = po - pgm(denoised(:,c));             %error is PSD of clean - PSD of filtered signal
RE_2 = sqrt( (err'*err)/(po'*po) )     %Relative Error in estimation/filtering

err =  s2h_original([1:N-1],c)-denoised(:,c) ;   %error is clean - filtered signals
PG_2=10*log10(var(s2h_original(:,c))/var(err))  %Prediction Gain performance measture



%Spectograms of pre and post filtered channels_____________________________
%Spectogram using 'Voicebox' toolbox by D.M.Brookes

figure(1)
spgrambw(s2h_original(:,1), FS, [], [0,8000], [-90,-40], 'Jcw');
title('Spectogram of original signal channel 1')

figure(2)
spgrambw(denoised(:,1), FS, [], [0,8000], [-90,-40], 'Jcw');
title('Spectogram of filtered signal channel 1')

figure(3)
spgrambw(s2h(:,1), FS, [], [0,8000], [-90,-40], 'Jcw');
title('Spectogram of corrupted signal channel 1')

figure(4)
spgrambw(s2h_original(:,2), FS, [], [0,8000], [-90,-40], 'Jcw');
title('Spectogram of original signal channel 2')

figure(5)
spgrambw(denoised(:,2), FS, [], [0,8000], [-90,-40], 'Jcw');
title('Spectogram of filtered signal channel 2')

figure(6)
spgrambw(s2h(:,2), FS, [], [0,8000], [-90,-40], 'Jcw');
title('Spectogram of corrupted signal channel 2')



%averaged periodograms of pre and post filtered channels___________________

L=1024;                     %frame length, 1024 = 23ms.
w=hann(L);                  %window to remove the discontinuity at frame edges
x=[0: 1/L : (L-1)/L]*FS;    %x-axis for plotting mean PSD against frequency

for i=0:floor(N/L)-1,       %loop finds PSD of consecutive frames
    po1(:, i+1)=2*pgm(s2h_original( (i*L+1) : L*(i+1) , 1 ).*w);  %original channel 1
    pc1(:, i+1)=2*pgm(s2h( (i*L+1) : L*(i+1) , 1 ).*w);           %corrupted channel 1
    pf1(:, i+1)=2*pgm(denoised( (i*L+1) : L*(i+1), 1 ).*w);           %filtered channel 1
    
    po2(:, i+1)=2*pgm(s2h_original( (i*L+1) : L*(i+1) , 2 ).*w);  %original channel 2
    pc2(:, i+1)=2*pgm(s2h( (i*L+1) : L*(i+1) , 2 ).*w);           %corrupted channel 2
    pf2(:, i+1)=2*pgm(denoised( (i*L+1) : L*(i+1), 2 ).*w);           %filtered channel 2
end

%The PSD were doubled above since only half will be dislpayed.

pom1=mean(po1, 2);           %finding the average PSD
pcm1=mean(pc1, 2);
pfm1=mean(pf1, 2);

pom2=mean(po2, 2);           
pcm2=mean(pc2, 2);
pfm2=mean(pf2, 2);

figure(7)
hold on
plot(x, 10*log10(pom1), 'blue', x, 10*log10(pcm1), 'red', x, 10*log10(pfm1), 'green')
hold off
title('Averaged PSD for signal channel 1')
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')
legend('Original','Corrupt','Filtered by NLMS')
xlim([0,FS/2])

figure(8)
plot(x, 10*log10(pom2), 'blue', x, 10*log10(pcm2), 'red', x, 10*log10(pfm2), 'green')
title('Averaged PSD for signal channel 2')
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')
legend('Original','Corrupt','Filtered by NLMS')
xlim([0,FS/2])



%non averaged periodograms of pre and post filtered channels_______________

x=[0: 1/N : (N-2)/N]*FS;    %x-axis for plotting PSD against frequency

figure(9)
plot(x, 10*log10(2*pgm(s2h_original([1:N-1],1))), 'blue', x, 10*log10(2*pgm(s2h([1:N-1],1))), 'red', x, 10*log10(2*pgm(denoised(:,1))), 'green')
title('PSD for signal channel 1')
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')
legend('Original','Corrupt','Filtered by NLMS')
xlim([0,FS/2])


figure(10)
plot(x, 10*log10(2*pgm(s2h_original([1:N-1],2))), 'blue', x, 10*log10(2*pgm(s2h([1:N-1],2))), 'red', x, 10*log10(2*pgm(denoised(:,2))), 'green')
title('PSD for signal channel 2')
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')
legend('Original','Corrupt','Filtered by NLMS')
xlim([0,FS/2])
