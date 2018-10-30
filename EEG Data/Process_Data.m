clear all
close all
clc

header = edfread('RightBlink01.edf','AssignToVariables',true);  %File name is input here

sz = size(F4);  %Looking at the length of the signal
x = 1:sz(1,2);  %Creating the t atis
Fs = 128;       %Sampling Rate
t = x/Fs;       %Converting samplerate to time in seconds

%ASGR = (AF3+F3+F7+FC5+P7+O1+T7)/7;
%ASGL = (AF4+F4+F8+FC6+P8+O2+T8)/7;

hold on

    plot(t,AF3,'b');
    plot(t,F3,'m');
    plot(t,F7,'r');
    plot(t,FC5,'k');
    plot(t,P7,'g');
    plot(t,O1,'c');
    plot(t,T7,'y');


 plot(t,AF4,'b');
 plot(t,F4,'m');
 plot(t,F8,'r');
 plot(t,FC6,'k');
 plot(t,P8,'g');
 plot(t,O2,'c');
 plot(t,T8,'y');
 
hold off 

figure('Name', 'Signal')
 
  xlabel('Time (s)');
  ylabel('Amplitude');
 % hold on; 
 
 %hold off;
 
 
 
 
%plot(derp/Fs,sin,'r')



y = fft(ASG);
m = abs(y);
f = (0:length(y)-1)*Fs/length(y);

%Halfing frequency range
Hf = find(f <= Fs/2);
Hf = size(Hf);
Hf = Hf(1,2);

M = m(:,2:Hf);
Hz = f(:,2:Hf);


figure('Name', 'Frequency domain')
plot(Hz,M)
  xlabel('Frequency (Hz)');
  ylabel('Magnitude');

%Filters:
HT = find(f <= 5);
HT = size(HT);
HT = HT(1,2);
y(1,Hf:end) = 0; %Delete things after Fs/2

%y(1,1:HT) = 0;
y(1,HT:end) = 0;

%y(1,595:615) = 0;

%Frequency domain after filter
v = abs(y);
V = v(:,2:Hf);

figure('Name', 'Frequency domain with filter')
plot(Hz,V)
  xlabel('Frequency (Hz)');
  ylabel('Magnitude');


figure('Name', 'Inverse fft with filter')
x2 = ifft(y);
plot(t,x2)
  xlabel('Time (s)');
  ylabel('Amplitude');


% %Artifacts
% BL = find(x2 <= 4200);
% x2(1,BL) = 0;
% 
% figure('Name', 'Artifact spike')
% plot(t,x2)
%   xlabel('Time (s)');
%   ylabel('Amplitude');



