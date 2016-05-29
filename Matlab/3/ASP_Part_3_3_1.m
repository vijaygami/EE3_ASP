clc;clear;

%1)_generating the DTMF signal______________________________________________
fs=32768;       %Sample frequency, Hz
idle=0.25;      %Idle time in seconds
len=0.25;       %length of digit pressing in seconds
rng(1);
number=[0,2,0,[randi([0,9], 1,8)]];        %random landline number generator


%loop generating the time sequence
y=[];
for i= 1:11,    
    y=[y, DTMF(len, fs, number(1,i))];          %generates the tones
    if(i < 11) y=[y,zeros(1,round(len*fs))];    %the spaces between the ones are zeroes.
    end
end

t=[1:length(y)]/fs; %x-axis

figure(1)
subplot(1,2,1)
plot(t,y)
title('Two tone signal for digit 0')
xlabel('Time / seconds')
ylabel('Amplitude')
xlim([0.240,0.252])

subplot(1,2,2)
plot(t,y)
title('Two tone signal for digit 2')
xlabel('Time / seconds')
ylabel('Amplitude')
xlim([0.498,0.51])



%2)_spectogram and PSD segments____________________________________________

w=hann(round(len*fs));       %hanning window of same length as dial tone duration
figure(2)
spectrogram(y, w, 0, round(len*fs), fs, 'yaxis');   %plotting the spectogram
ylim([0,2300])
title('Spectogram for DTMF sequence')

[s, w, t] = spectrogram(y, w, 0, round(len*fs) ,fs);  %the coresponding FFT segments. (repeated the function call since some options do not work whith output arguments)


%PSD segments
figure(3); clf;
f=[1:round(len*fs)/2+1].*(fs/round(len*fs));
for i=0:10
    
    subplot(2,6,i+1)
    plot(f, (  10*log10(  s(: , 1+2*i).*conj(s(: , 1+2*i)) )  )   )
    title(['Short time PSD showing digit ' num2str(number(i+1))])
    xlim([0,2300])
    xlabel('Frequency / Hz')
    ylabel('Power/Hz (dB)')
    
end
