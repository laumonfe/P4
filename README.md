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



