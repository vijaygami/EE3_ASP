clc;clear;
load vinyl.mat

c=1;            %channel under analysis. switch between 1,2.
N=1345050;      %length of segments of audio

noise=s2h-s2h_original;             %'tick' noise
co=audioplayer(s2h, FS);            %corrupted segment
cl=audioplayer(s2h_original, FS);   %clean segment
n=audioplayer(noise,FS);

%play(co)
%play(n)


%Plotting the PSD of corrupted, clean and noise signals.___________________

% double PSD amplitude since will only show half the spectrum from 0 -> fs/2
po = 2*pgm(s2h(:,c).*hann(N));                 
pc = 2*pgm(s2h_original(:,c).*hann(N));
pn = 2*pgm(noise(:,c).*hann(N));

figure(1)
subplot(1,3,1);
plot([0 : 1/N : (N-1)/N].*FS, 10*log10(po));  
xlim([0,FS/2])
ylim([-150,20])
title(['PSD for corrupted signal channel: ' num2str(c)])
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')

subplot(1,3,2);
plot([0 : 1/N : (N-1)/N].*FS, 10*log10(pc));
xlim([0,FS/2])
ylim([-150,20])
title(['PSD for clean signal channel: ' num2str(c)])
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')

subplot(1,3,3);
plot([0 : 1/N : (N-1)/N].*FS, 10*log10(pn));
xlim([0,FS/2])
title(['PSD for corrupted-clean signal, channel: ' num2str(c)])
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')


%plotting averaged PSD of consecutive frames of length L.__________________

L=1024;                     %window length, 1024=23ms.
w=hann(L);                  %window to remove the discontinuity at frame edges
x=[0: 1/L : (L-1)/L]*FS;    %x-axis for plotting mean PSD against frequency

for i=0:floor(N/L)-1,       %loop finds PSD of consecutive frames
    pc1(:, i+1)=2*pgm(s2h( (i*L+1) : L*(i+1) , c ).*w);           %noisy
    po1(:, i+1)=2*pgm(s2h_original( (i*L+1) : L*(i+1) , c ).*w);  %clean (original)
    pn1(:, i+1)=2*pgm(noise( (i*L+1) : L*(i+1), c ).*w);          %noise
end

pom=mean(po1, 2);           %finding the average PSD
pcm=mean(pc1, 2);
pnm=mean(pn1, 2);

%plotting averaged PSD
figure(2);
subplot(1,3,1);
plot(x, 10*log10(pcm));  
xlim([0,FS/2])
title(['Averaged framed PSD for corrupted signal channel: ' num2str(c)])
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')

subplot(1,3,2);
plot(x, 10*log10(pom));
xlim([0,FS/2])
title(['Averaged framed PSD for clean signal channel: ' num2str(c)])
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')

subplot(1,3,3);
plot(x, 10*log10(pnm));
xlim([0,FS/2])
title(['Averaged framed PSD for corrupted-clean signal, channel: ' num2str(c)])
xlabel('Frequency / Hz')
ylabel('Power / frequency (dB / Hz)')


%spectograms_______________________________________________________________
%Spectogram using 'Voicebox' toolbox by D.M.Brookes

figure(3)
spgrambw(s2h(:,c), FS, [], [0,8000], [-90,-40], 'Jcw');     
title('Spectogram of corrupted segment')

figure(4)
spgrambw(s2h_original(:,c), FS, [], [0,8000], [-90,-40], 'Jcw');
title('Spectogram of clean segment')

figure(5)
spgrambw(noise(:,c), FS, [], [0,8000], [-90,-40], 'Jcw');
title('Spectogram of noise')
