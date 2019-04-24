%%
close all;                                 %________ 
clear;                                     %Clean Up. 
clc;                                       %________ 

x=serial('/dev/ttyACM0','BAUD', 9600);     % Serial Connect Arduino (Port may vary).
fopen(x);                                  % Open Arduino Port Communication.
go = true;                                 % Bool value for inf loop.
%%

while go                                   % Initialize loop till inf.
    Fs = 44100;                            % Sampling frequency.
    a = audiorecorder(Fs,24,1);            % Initialize Recorder(Sample rate,Data bits,Channel)
    rectime = 1;                           % Record time.
    record(a,rectime)                      % Record.  
    pause(rectime);                        % pause code to wait to record.
    b = getaudiodata(a);                   % get recorded data.  
    %sound(b)                              % To play the recorded sound.
    T = 1/Fs;                              % Sampling period.
    L = length(b);                         % Length of signal.
    t = (0:L-1)*T;                         % Time vector.
    figure(1);                              
    plot(b)                                % Plotting Data in time domain.
    Y = fft(b);                            % FFT on recorded data. 
    P2 = abs(Y/L);                         % _________________________________
    P1 = P2(1:L/2+1);                       
    P1(2:end-1) = 2*P1(2:end-1);           % Plotting Logic in Frequncy Domain. 
    f = Fs*(0:(L/2))/L;                    %__________________________________ 
    figure(2);
    plot(f,P1);                            % Plotting data in Frequncy Domain.
    title('Frequncy Analyzed Data');       %_________
    xlabel('f (Hz)');                      % Labeling.
    ylabel('|P1(f)|');                     %_________
    [q,w] = max(P1);                       % Finding Index Of max Frequncy.
    wave = f(w);                           % Finding the Max Frequncy. 
    disp('Frequency is',wave,'Hz');        % Displaying Max frequncy. 
    if wave > 0 && wave < 20               %__________________________ 
        disp('ALPHA');
        a = 2;                             % Condition for alpha waves. 
    end                                    %__________________________
    if wave > 20                           %_________________________         
        disp('BETA');
        a = 1;                             % Condition for beta waves. 
    end                                    %_________________________   
    fprintf(x,a);                          % Sending Data to Arduino for actuation .
end                                        % End inf loop.