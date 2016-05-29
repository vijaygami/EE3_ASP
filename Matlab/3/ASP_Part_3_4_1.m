load RRI_r_e.mat    %load both emads and raweeds RRI data, sample frequency is 4HZ
                    %for trial 1, 3, emads data is used, size 440
                    %for trial 2 raweeds data is used, size 580

%zero mean data
RRI_trial_1_e=detrend(RRI_trial_1_e);
RRI_trial_2_r=detrend(RRI_trial_2_r);
RRI_trial_3_e=detrend(RRI_trial_3_e);

fs=4;   %sample frequency

%standard periodogram estimate (no averaging). Hanning window used.
figure(1)
subplot(1,3,1)
plot([0: 1/440 : (440-1)/440]*fs, 10*log10(pgm((RRI_trial_1_e.*hann(440)')')))
title('PSD estimate for RRI Trial 1')
xlabel('Frequency / Hz )')
ylabel('Power/frequency (dB/rad/sample)')
ylim([-110, 10])
xlim([0,fs/2])

subplot(1,3,2)
plot([0: 1/580 : (580-1)/580]*fs, 10*log10(pgm((RRI_trial_2_r.*hann(580)')')))
title('PSD estimate for RRI Trial 2')
xlabel('Frequency / Hz )')
ylabel('Power/frequency (dB/rad/sample)')
ylim([-110, 10])
xlim([0,fs/2])

subplot(1,3,3)
plot([0: 1/440 : (440-1)/440]*fs, 10*log10(pgm((RRI_trial_3_e.*hann(440)')')))
title('PSD estimate for RRI Trial 3')
xlabel('Frequency / Hz )')
ylabel('Power/frequency (dB/rad/sample)')
ylim([-110, 10])
xlim([0,fs/2])



%averaged periodogram window length L samples
L=150;                  %window length
w=hann(L);              %window to remove the discontinuity at frame edges
%w=ones(L,1);%no windowing.
x=[0: 1/L : (L-1)/L]*fs;   %x-axis for plotting PSD against normalised frequency

p1e=[];
p2r=[];
p3e=[];
%trials 1, 3:
for i=0:floor(440/L)-1,
    p1e(:, i+1)=pgm(((RRI_trial_1_e( (i*L+1) : L*(i+1) )).*w')');
    p3e(:, i+1)=pgm(((RRI_trial_3_e( (i*L+1) : L*(i+1) )).*w')');
end
%trial 2:
for i=0:floor(580/L)-1,
    p2r(:, i+1)=pgm(((RRI_trial_2_r( (i*L+1) : L*(i+1) )).*w')');
end

m_p1e=mean(p1e, 2);
m_p2r=mean(p2r, 2);
m_p3e=mean(p3e, 2);



%plotting averaged periodograms for the three trials
figure(2)
subplot(1,3,1)
plot(x, 10*log10(m_p1e))
title(['Averaged PSD estimate for RRI Trial 1. Window length: ' num2str(L)])
xlabel('Normalised frequency (x2\pi rad/sample)')
xlabel('Frequency / Hz ')
ylim([-100, 0])
xlim([0,fs/2])

subplot(1,3,2)
plot(x, 10*log10(m_p2r))
title(['Averaged PSD estimate for RRI Trial 2. Window length: ' num2str(L)])
xlabel('Frequency / Hz )')
ylabel('Power/frequency (dB/rad/sample)')
ylim([-100, 0])
xlim([0,fs/2])

subplot(1,3,3)
plot(x, 10*log10(m_p3e))
title(['Averaged PSD estimate for RRI Trial 3. Window length: ' num2str(L)])
xlabel('Frequency / Hz ')
ylabel('Power/frequency (dB/rad/sample)')
ylim([-100, 0])
xlim([0,fs/2])