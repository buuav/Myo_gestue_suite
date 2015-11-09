clc;
clear;
t = tcpip('155.41.75.111',55000,'NetworkRole','client');
set(t, 'InputBufferSize', 5000);
fopen(t);
i = 1;
time=clock;
while etime(clock,time)<48
    if t.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        %data(i,:) = fscanf(t, '%d,%d,%d,%d,%d,%d,%d,%d\r\n')';
        data(i,:) = char(fread(t,5,'char'));
        %pause(0.1);
        i = i + 1
    end
end
etime(clock,time)
 [a,b]=size(data);
for i=1:b
    subplot(4,2,i);
    plot(data(:,i));
end
fclose(t);
