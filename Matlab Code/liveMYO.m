clc;
clear;

t = tcpip('192.168.1.2', 3000,'NetworkRole','client');
set(t, 'InputBufferSize', 64);
fopen(t);
i = 1;
time=clock;
fs=200;
%nor__OUT_FIST_In_spread
while etime(clock,time)<30
    if t.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        data(i,:) = fscanf(t, '%d,%d,%d,%d,%d,%d,%d,%d\r\n')';
        
        i = i + 1;
    end
end

fclose(t);