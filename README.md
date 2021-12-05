# P4
Using EEG signals to control a 6 DOF Kinova JACO2. To do this projet, EEG artifacts were recorded with
an Emotive Epoc headset. This signals were then processed in matlab and used to control the Kinova Jaco 
through its SDK. For this application, 7 different menus to control the manipulator were created: 

- Open and Close gripper
- Right and left
- Up and down
- Forwards and backwards
- Yaw +/-
- Pitch +/-
- Roll +/-

Where blink the right eye means the first option, e.g. In the open and close gripper menu, "right blink" = open, and "left blink" = close. 
And blinking both eyes simultaneusly will trigger a menu change. E.g. From open and close menu to right and left menu. 


Test 1: 

https://user-images.githubusercontent.com/24587645/144747639-04852025-6e30-4c9b-ba42-af744a7b2106.mp4


Test 2 : 

https://user-images.githubusercontent.com/24587645/144747646-2902284e-2dfa-4c06-a9bb-1117785cffbd.mp4

