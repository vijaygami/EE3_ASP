%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script filters the tick from channel 1. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear;
load vinyl.mat;
c=1;                        %channel to be filtered
N=1345050;                  %length of suond segments
noise=s2h-s2h_original;     %extracted noise



% Constant coefficient filter: generating coeficients:_____________________

rp = 0.025;                 % Passband ripple in dB
rs = 40;                    % Stopband ripple in dB
fs = 44100;                 % Sampling frequency in Hz
f = [1350 1450 1550 1650];  % Cutoff frequencies in Hz
a = [1 0 1];                % Desired amplitudes (Bandpass)

%converting the deviations in the stop and pass bands from dB to absolute values as needed for firpmord.
dev = [(10^(rp/20)-1)/(10^(rp/20)+1), 10^(-rs/20), (10^(rp/20)-1)/(10^(rp/20)+1) ];

% firpmord the approximate order, normalized frequency band edges, frequency band amplitudes, 
% and weights which meet input specifications f, a, and dev. 
[n,fo,ao,w] = firpmord(f,a,dev,fs);

% firpm uses the Parks-McClellan algorithm to return the coeficients (n+1)
b = firpm(n,fo,ao,w);

% Verify frequency response
freqz(b, 1, 8192, FS);



%performing filtering and listening to results_____________________________

filtered = filter(b,1,s2h(:,c));

cor=audioplayer(s2h(:,c),FS);           %corrupt signal. signle channel only
cl=audioplayer(s2h_original(:,c),FS);   %Original clean. signle channel only
a=audioplayer(filtered,FS);             %filtered signal

play(a)



%spectograms to confirm tick removal_______________________________________
%Spectogram using 'Voicebox' toolbox by D.M.Brookes
figure(1)
spgrambw(s2h_original(:,c), FS, [], [0,8000], [-90,-40], 'Jcw');
title(['Spectogram of original signal channel ', num2str(c)])

figure(2)
spgrambw(filtered, FS, [], [0,8000], [-90,-40], 'Jcw');
title(['Spectogram of filtered signal channel ', num2str(c)])

figure(3)
spgrambw(s2h(:,c), FS, [], [0,8000], [-90,-40], 'Jcw');
title(['Spectogram of corrupted signal channel ', num2str(c)])


%saves filtered data to current folder. used by script 'ASP_Part_5_4.mat'
%to compare to ideal clean data.
save('filtered_c1.mat', 'filtered'); 





