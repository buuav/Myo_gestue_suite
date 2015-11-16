clc;
clear;

t = tcpip('128.197.50.236', 3000,'NetworkRole','client');
set(t, 'InputBufferSize', 64);
fopen(t);
i = 1;
time=clock;
fs=200;

%nor__OUT_FIST_In_spread
while etime(clock,time)<48
    if t.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        data(i,:) = fscanf(t, '%d,%d,%d,%d,%d,%d,%d,%d\r\n')';
        
        i = i + 1;
    end
end

fclose(t);