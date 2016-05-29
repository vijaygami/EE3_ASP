function [ y ] = DTMF( length, fs, digit )
% Outputs Dual tome Multi Frequency series with sample frequecy fs and
% duration as specified by input 'length'.
%
%                 1209 Hz   1336 Hz   1477 Hz
%                _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
%               |         |         |         |
%       697 Hz  |    1    |    2    |    3    |
%               |_ _ _ _ __ _ _ _ __ _ _ _ _ _|
%               |         |         |         |
%       770 Hz  |    4    |    5    |    6    |
%               |_ _ _ _ __ _ _ _ __ _ _ _ _ _|
%               |         |         |         |
%       852 Hz  |    7    |    8    |    9    |
%               |_ _ _ _ __ _ _ _ __ _ _ _ _ _|
%               |         |         |         |
%       941 Hz  |    *    |    0    |    #    |
%               |_ _ _ _ __ _ _ _ __ _ _ _ _ _|

lookup=[
    0, 941, 1336;
    1, 697, 1209;
    2, 697, 1336;
    3, 697, 1477;
    4, 770, 1209;
    5, 770, 1336;
    6, 770, 1477;
    7, 852, 1209;
    8, 852, 1336;
    9, 852, 1477
    ];

n=[0:(round(length*fs)-1)];
y=sin(2*pi*lookup((digit+1), 2)*n/fs) + sin(2*pi*lookup((digit+1), 3)*n/fs);

end

