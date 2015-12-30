clc;
clear;

t = tcpip('192.168.1.101', 3000,'NetworkRole','client');
set(t, 'InputBufferSize', 2000);
fopen(t);
i = 1;
time=clock;
fs=200;

%nor__OUT_FIST_In_spread
while etime(clock,time)<20
    if t.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        data(i,:) = fscanf(t, '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\r\n')'; %IMU reading
        numel(data(i,:));
        i = i + 1;
    end
    disp('hi');
end
 
fclose(t);