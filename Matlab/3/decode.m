function [digit ] = decode( y, fs, win_len )
%decodes the digit sequnece  input y (row vector) )with sample frequency fs. win_len
%is the time duration of the window to be used. assumption is that tone
%duration = silence duration and these are both known and equal to win_len.

w=(hann(round((win_len)*fs)))';     %window of duration 'win_len' seconds
s=length(w);                        %number of samples per frame/window
s2=length(y);                       %size of input y to decode
frames=floor(s2/s);                 %number of complete frames to fit in sequency y

p=[];
for i=0:frames-1,
    
    p(:, i+1) = pgm(((y((i*s+1) : s*(i+1))).*w)');
    [peak(:,i+1),loc(:,i+1)]=findpeaks(p(:, i+1),'npeaks',4,'sortstr','descend'); %finds top 4 peaks whihc correspond to the two tone frequencies.

    %determine frequency pairs during tone periods and ignore the periods of silence.
    if mod(i+1,2) == 1,
        freqs(:,(i/2)+1)=[round(fs*(loc(1,i+1)-1)/s) ; round(fs*(loc(3,i+1)-1)/s)];
    end
    
end

%round to nearest tone sinusoids. 'extrap' needed if value to be rounded 
%is outside range of the frequencies to round to. 
round_to = [697, 770, 852, 941, 1209, 1336, 1477]; %vector of frequencies to round to.
freqs = interp1(round_to, round_to, freqs, 'nearest', 'extrap');


%decode frequency pairs into digits. (lookup table would probably be more
%efficient)
s=size(freqs); s=s(1,2); 
digit=[];

for i=1:s;
    if ((freqs(1,i)==697 && freqs(2,i)==1209) || (freqs(2,i)==697 && freqs(1,i)==1209)) digit(i)=1;
    elseif ((freqs(1,i)==697 && freqs(2,i)==1336) || (freqs(2,i)==697 && freqs(1,i)==1336)) digit(i)=2;
    elseif ((freqs(1,i)==697 && freqs(2,i)==1477) || (freqs(2,i)==697 && freqs(1,i)==1477)) digit(i)=3;
    elseif ((freqs(1,i)==770 && freqs(2,i)==1209) || (freqs(2,i)==770 && freqs(1,i)==1209)) digit(i)=4;
    elseif ((freqs(1,i)==770 && freqs(2,i)==1336) || (freqs(2,i)==770 && freqs(1,i)==1336)) digit(i)=5;
    elseif ((freqs(1,i)==770 && freqs(2,i)==1477) || (freqs(2,i)==770 && freqs(1,i)==1477)) digit(i)=6;
    elseif ((freqs(1,i)==852 && freqs(2,i)==1209) || (freqs(2,i)==852 && freqs(1,i)==1209)) digit(i)=7;
    elseif ((freqs(1,i)==852 && freqs(2,i)==1336) || (freqs(2,i)==852 && freqs(1,i)==1336)) digit(i)=8;
    elseif ((freqs(1,i)==852 && freqs(2,i)==1477) || (freqs(2,i)==852 && freqs(1,i)==1477)) digit(i)=9;
    end
end


end



