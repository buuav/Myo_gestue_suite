left=0;
right=0;
up=0;
down=0;
mystate=1;
i=1;

data = 0;
%data = num2str([up,down,left,right,mystate]);
s = whos('data');

tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
set(tcpipServer,'OutputBufferSize',s.bytes);
fopen(tcpipServer);

t = tcpip('128.197.50.77', 10000,'NetworkRole','client');
set(t, 'InputBufferSize', 400);
fopen(t);
i = 1;
time=clock;
fs=200;
lrswitch=0;
%nor__OUT_FIST_In_spread
while etime(clock,time)<200
    if t.BytesAvailable
        rawdata(i,:) = fscanf(t, '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\r\n')';
        [m,n]=size(rawdata);
        
        R = quatrn2rot(rawdata(i,7:10));
        euler(i,1:3) = rot2ZYXeuler(R)*(180/3.1459);
        accel(i,1:3) = rawdata(i,1:3);
        gyro(i,1:3) = rawdata(i,4:6);
        
        if gyro(i,1) < -200
            data = 1;
        elseif gyro(i,1) > 200
            data = 2;
        elseif gyro(i,3) > 80 && lrswitch<=0
           data = 3;
            %lrswitch = lrswitch +1;
        elseif gyro(i,3) < -80 && lrswitch>=0
           data = 4;
            %lrswitch = lrswitch -1;   
        elseif euler(i,2) < -40
            data = 5;
        elseif euler(i,2) > 40
            data = 6;
        end
%      if lrswitch==1
%          data=3;
%      elseif lrswitch==-1
%          data=4;
%      end
     
        fwrite(tcpipServer,num2str(data),'char')
       % if ~mod(m,o) && m > 99
       %    tempdata=mean(euler(i-99:2));
       %     data = num2str(round(tempdata))
       %     fwrite(tcpipServer,data,'char');
       % end
        
        i = i + 1;
        
        data = 0;
        
    end
    
end

fclose(t);
fclose(tcpipServer);







