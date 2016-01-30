clc;
clear;

t1 = tcpip('128.197.50.77', 10000,'NetworkRole','client');
t2 = tcpip('128.197.50.77', 3000,'NetworkRole','client');
set(t1, 'InputBufferSize', 400);
set(t2, 'InputBufferSize', 400);
fopen(t1);
% fopen(t2);
i = 1;
j = 1;
time=clock;
fs=200;

%nor__OUT_FIST_In_spread
while etime(clock,time)<10
%     if t2.BytesAvailable
%         %data(i,:) = strsplit(fread(t),'\r\n');
%         dataemg(j,:) = fscanf(t2, '%f,%f,%f,%f,%f,%f,%f,%f\r\n')'; %EMG reading
%         %numel(dataimu(i,:));
%         j = j + 1;
%     end
    if t1.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        dataimu(i,:) = fscanf(t1, '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\r\n')'; %IMU reading
        %numel(dataimu(i,:));
        R = quatrn2rot(dataimu(i,7:10));
        euler(i,1:3) = rot2ZYXeuler(R)*(180/3.1459);
        accel(i,1:3) = dataimu(i,1:3);
        gyro(i,1:3) = dataimu(i,4:6);
        i = i + 1;
    end
    
    %disp('hi');
end
fclose(t1);
% fclose(t2);
varstr=horzcat(datestr(clock,30),'.mat');
save(varstr);

figure
suptitle('Accelerometer')
[a,b]=size(accel);
xaxis=1/50:1/50:a/50;
% nlines=round(a/600);
for i=1:b
    subplot(1,3,i);
    plot(xaxis,accel(:,i));
    %title('hi %i',i);
%     for j=1:nlines
%     line([3*j 3*j], [-200 200]);
%     end
end

figure
suptitle('Gyro')
[a,b]=size(gyro);
xaxis=1/50:1/50:a/50;
% nlines=round(a/600);
for i=1:b
    subplot(1,3,i);
    plot(xaxis,gyro(:,i));
    %title('hi %i',i);
%     for j=1:nlines
%     line([3*j 3*j], [-200 200]);
%     end
end

figure
suptitle('euler angles')
[a,b]=size(euler);
xaxis=1/50:1/50:a/50;
% nlines=round(a/600);
for i=1:b
    subplot(1,3,i);
    plot(xaxis,euler(:,i));
    %title('hi %i',i);
%     for j=1:nlines
%     line([3*j 3*j], [-200 200]);
%     end
end