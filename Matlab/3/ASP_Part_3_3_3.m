%clc;clear;

fs=32768;       %Sample frequency, Hz
idle=0.25;      %Idle time in seconds
len=0.25;       %length of digit pressing in seconds
o=50;            %Additive WGN power
rng(1);
number=[0,2,0,[randi([0,9], 1,8)]];        %random landline number generator


%loop generating the time sequence
y=[];
for i= 1:11,    
    y=[y, DTMF(len, fs, number(1,i))];          %generates the tones
    if(i < 11) y=[y,zeros(1,round(len*fs))];    %the spaces between the ones are zeroes.
    end
end


y_noisy=y+sqrt(o)*randn(1,21*round(len*fs));    %noisy tone
a=audioplayer(y_noisy, fs);                     %listening to see if tone can be heard
play(a);

%plotting the noisy waveform in time
figure(1)
t=[1:length(y)]/fs; %x-axis (time)
subplot(1,2,1)
plot(t,y_noisy)
title(['Two tone noisy signal for digit 0. Noise power: ' num2str(o)])
xlabel('Time / seconds')
ylabel('Amplitude')
xlim([0.240,0.252])

subplot(1,2,2)
plot(t,y_noisy)
title(['Two tone noisy signal for digit 2. Noise power: ' num2str(o)])
xlabel('Time / seconds')
ylabel('Amplitude')
xlim([0.498,0.51])

%spectogram
w=hann(round(len*fs));                          %hanning window of same length as dial tone duration
figure(2)
spgrambw(y_noisy, fs, [], [0,2300], 'Jcw');     %better spectogram using 'Voicebox' toolbox by D.M.Brookes
title(['DTMF spectrogram. Noise power: ' num2str(o)])


[decoded ]=decode(y_noisy,fs,0.25);             %function to decode noisy signal into digits
number                                          %checking if decoded value is correct                             
decoded

%PSD segments
[s, w, t] = spectrogram(y_noisy, w, 0, round(len*fs) ,fs);  %the coresponding FFT segments. 


%PSD segments
figure(3)
f=[1:round(len*fs)/2+1].*(fs/round(len*fs));
for i=0:10
    
    subplot(2,6,i+1)
    plot(f, (  10*log10(  s(: , 1+2*i).*conj(s(: , 1+2*i)) )  )   )
    title(['Short time PSD showing digit ' num2str(number(i+1))])
    xlim([0,2300])
    xlabel('Frequency / Hz')
    ylabel('Power/Hz (dB)')
    
end
