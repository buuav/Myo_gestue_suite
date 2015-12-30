clc;
clear;

t1 = tcpip('192.168.1.101', 3000,'NetworkRole','client');
t2 = tcpip('192.168.1.101', 55000,'NetworkRole','client');
set(t1, 'InputBufferSize', 400);
set(t2, 'InputBufferSize', 400);
fopen(t1);
fopen(t2);
i = 1;
j = 1;
time=clock;
fs=200;

%nor__OUT_FIST_In_spread
while etime(clock,time)<100
    if t2.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        dataemg(j,:) = fscanf(t2, '%f,%f,%f,%f,%f,%f,%f,%f\r\n')'; %EMG reading
        %numel(dataimu(i,:));
        j = j + 1;
    end
    if t1.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        dataimu(i,:) = fscanf(t1, '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\r\n')'; %IMU reading
        %numel(dataimu(i,:));
        i = i + 1;
    end
    
    %disp('hi');
end
 
fclose(t1);
fclose(t2);