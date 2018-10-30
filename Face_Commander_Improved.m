clear all
close all
clc

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
robot=Robot;


header = edfread('CarstenHard01.edf','AssignToVariables',true);  %File name is input here

Fs = 128;         %Sampling Rate
Ts = 1;
Thres = 4300;     %Threshold

Feed_F7(1:Fs*Ts) = 4000;
Feed_F8(1:Fs*Ts) = 4000;
i = 1;
Detected = 0;
Artifact = 0;
Command = 0;
Menu = 0;
Once = 0;
C_A = zeros(1,9);


sz = length(Feed_F7);  %Looking at the length of the signal
x = 1:sz;              %Creating the t axis
t = x/Fs;              %Converting samplerate to time in seconds

    %figure('Name', 'Signal')
    %hold on;
    
Left_F7 = (AF3+F3+F7+FC5+T7)/5;
Right_F8 = (AF4+F4+F8+FC6+T8)/5;
    

pause(5);
    
while (i < length(F7))
    
    Feed_F7(1,Fs*Ts) = Left_F7(1,i);
    Feed_F8(1,Fs*Ts) = Right_F8(1,i);
    

    %Finding fft of signals
    Feed_F7_fft = fft(Feed_F7);
    Feed_F8_fft = fft(Feed_F8);


    %Frequency axis
    f = (0:length(Feed_F7_fft)-1)*Fs/length(Feed_F7_fft);


    %Halfing frequency range
    Hf = find(f <= Fs/2);
    Hf = length(Hf);
    Hz = f(:,2:Hf);


    %Delete things after Fs/2
    Feed_F7_fft(1,Hf:end) = 0;
    Feed_F8_fft(1,Hf:end) = 0;


    %Applying filter
    HT = find(f <= 5); %Actual filter (lowpass at 5Hz)
    HT = length(HT);

    Feed_F7_fft(1,HT:end) = 0;
    Feed_F8_fft(1,HT:end) = 0;


    %Inverse fft
    Feed_F7_inv = ifft(Feed_F7_fft);
    Feed_F8_inv = ifft(Feed_F8_fft);

    
    
    
    if (Feed_F7_inv(1,(Fs*Ts)/2) > Thres)
        Detected = 2; %Left
    end
    
    if (Feed_F8_inv(1,(Fs*Ts)/2) > Thres)
        Detected = 3; %Right
    end
    
    if (Feed_F7_inv(1,(Fs*Ts)/2) > Thres & Feed_F8_inv(1,(Fs*Ts)/2) > 4300)
        Detected = 4; %Both
    end
    
    if (Feed_F7_inv(1,(Fs*Ts)/2) < Thres & Feed_F8_inv(1,(Fs*Ts)/2) < 4300)
        Detected = 1;
    end
    
    C_A(1,1) = Detected;
    C_A = circshift(C_A,1);
    
    [a,b]=hist(C_A,unique(C_A));
    
    if (sum(C_A) ~= 0)
        Artifact = b(1,find(a == max(a)));
    end
    if (sum(C_A) == 0 || length(Artifact) > 1);
        Artifact = 1;
    end
    
    
    
    switch Artifact
        case 1
            Command = 0;
            Once = 0;
        case 2 %Left
            switch Menu
                case 0;  Command = 1;
                case 1;  Command = 3;
                case 2;  Command = 5;
                case 3;  Command = 7;
                case 4;  Command = 9;
                case 5;  Command = 11;
                case 6;  Command = 13;
            end
        case 3 %Right
            switch Menu
                case 0;  Command = 2;
                case 1;  Command = 4;
                case 2;  Command = 6;
                case 3;  Command = 8;
                case 4;  Command = 10;
                case 5;  Command = 12;
                case 6;  Command = 14; 
            end
        case 4 %Both
            if (Once == 0)
                Menu = Menu+1;
                    if (Menu == 7)
                        Menu = 0;
                    end
                Once = 1;
                Command = 0;
            end
    end
                    
            
    
    switch Command
        case 1;  robot.keyPress(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 2;  robot.keyPress(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 3;  robot.keyPress(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 4;  robot.keyPress(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 5;  robot.keyPress(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 6;  robot.keyPress(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 7;  robot.keyPress(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 8;  robot.keyPress(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 9;  robot.keyPress(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 10; robot.keyPress(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 11; robot.keyPress(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 12; robot.keyPress(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_U);
        case 13; robot.keyPress(KeyEvent.VK_O);
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_U);
        case 14; robot.keyPress(KeyEvent.VK_U);
        otherwise;
            robot.keyRelease(KeyEvent.VK_Y);
            robot.keyRelease(KeyEvent.VK_Z);
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_S);
            robot.keyRelease(KeyEvent.VK_W);
            robot.keyRelease(KeyEvent.VK_E);
            robot.keyRelease(KeyEvent.VK_Q);
            robot.keyRelease(KeyEvent.VK_J);
            robot.keyRelease(KeyEvent.VK_L);
            robot.keyRelease(KeyEvent.VK_K);
            robot.keyRelease(KeyEvent.VK_I);
            robot.keyRelease(KeyEvent.VK_O);
    end
    
    
    

    %Settings for next run
    i = i+1;
    
    Feed_F7 = circshift(Feed_F7,-1);
    Feed_F8 = circshift(Feed_F8,-1);
    
    
    
%     robot.keyRelease(KeyEvent.VK_Y);
%     robot.keyRelease(KeyEvent.VK_Z);
%     robot.keyRelease(KeyEvent.VK_D);
%     robot.keyRelease(KeyEvent.VK_A);dddddddddddddddddddddddd
%     robot.keyRelease(KeyEvent.VK_S);
%     robot.keyRelease(KeyEvent.VK_W);
%     robot.keyRelease(KeyEvent.VK_E);
%     robot.keyRelease(KeyEvent.VK_Q);
%     robot.keyRelease(KeyEvent.VK_J);
%     robot.keyRelease(KeyEvent.VK_L);
%     robot.keyRelease(KeyEvent.VK_K);
%     robot.keyRelease(KeyEvent.VK_I);
%     robot.keyRelease(KeyEvent.VK_O);
%     robot.keyRelease(KeyEvent.VK_U);
    
    clc
    pause(0.00051)
    %pause(0.00101);
    %pause(0.00701);
    
    Derp = Artifact - 1
    Menu
    Command
    
    
    
    
    
    
    
    
    
%     %Plotting Signals
%         subplot(2,1,1)
%             plot(t,real(Feed_F7_inv))
%             xlabel('Time (s)');
%             ylabel('Amplitude');
%             ylim([3500 4500]);
%             xlim([0 Ts]);
%             title('F7 (Left side)');
% 
% 
%         subplot(2,1,2)
%             plot(t,real(Feed_F8_inv))
%             xlabel('Time (s)');
%             ylabel('Amplitude');
%             ylim([3500 4500]);
%             xlim([0 Ts]);
%             title('F8 (Right side)');
    
    
    
end


