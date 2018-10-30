clear; clf;

fid = fopen(['D:\Robotics\4thSEMESTER\Project\Person1.txt'],'r')
Data = fscanf(fid, '%f', [3,inf]);
fclose(fid);

whos Data; 
Data = Data';


% S = std(Data)
% mu = mean(Data)
fid = fopen(['D:\Robotics\4thSEMESTER\Project\Person2.txt'],'r')
Data2 = fscanf(fid, '%f', [3,inf]);
fclose(fid);

whos Data2; 
Data2 = Data2';

fid = fopen(['D:\Robotics\4thSEMESTER\Project\Person3.txt'],'r')
Data3 = fscanf(fid, '%f', [3,inf]);
fclose(fid);

whos Data3; 
Data3 = Data3'; 

fid = fopen(['D:\Robotics\4thSEMESTER\Project\Person4.txt'],'r')
Data4 = fscanf(fid, '%f', [3,inf]);
fclose(fid);

whos Data4; 
Data4 = Data4';

fid = fopen(['D:\Robotics\4thSEMESTER\Project\Person5.txt'],'r')
Data5 = fscanf(fid, '%f', [3,inf]);
fclose(fid);

whos Data5; 
Data5= Data5';

% fid = fopen(['C:\Users\laumo\Desktop\Robotics\4thSEMESTER\Project\RefPoint.txt'],'r')
% Data = fscanf(fid, '%f', [3,inf]);
% fclose(fid);
% 
% whos Data6; 
% Data6= Data6';
Data6 = [0.2884, -0.2207, 0.5791; 0.3067, -0.2356, 0.5125 ; 0.2487, -0.2308, 0.5757];

x=Data(:,1); y=Data(:,2); z=Data(:,3);
x=Data2(:,1); y=Data2(:,2); z=Data2(:,3);
x=Data3(:,1); y=Data3(:,2); z=Data3(:,3);
x=Data4(:,1); y=Data4(:,2); z=Data4(:,3);
x=Data5(:,1); y=Data5(:,2); z=Data5(:,3);
x=Data6(:,1); y=Data6(:,2); z=Data6(:,3);

figure;hist(Data)


f1= figure(1); hold on;
%set(f1, 'renderer', 'zbuffer');
plot3(Data(:,1),Data(:,2),Data(:,3), 'b.')
hold on
plot3(Data2(:,1),Data2(:,2),Data2(:,3),'r.');
plot3(Data3(:,1),Data3(:,2),Data3(:,3), 'g.');
plot3(Data4(:,1),Data4(:,2),Data4(:,3), 'y.');
plot3(Data5(:,1),Data5(:,2),Data5(:,3), 'm.');
plot3(Data6(:,1),Data6(:,2),Data6(:,3), 'kx');
hold off
view([-20 30]); grid on; 
view(0,90); 
view(0,0); 
view(90,0); 
