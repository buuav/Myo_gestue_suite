leftFlip=1;
rightFlip=2;
ForwardFlip=3;
BackwardFlip=4;
takeoff = 0;
land = 5;

mystate=1;
i=1;
%data = num2str([up,down,left,right,mystate]);
s = whos('data');

tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
set(tcpipServer,'OutputBufferSize',s.bytes);
fopen(tcpipServer);


count = 1;
time=clock;

%nor__OUT_FIST_In_spread
while etime(clock,time)<40
    
        if(etime(clock, time) < 5)
            data = num2str(takeoff);
            fwrite(tcpipServer,data,'char');
        elseif(etime(clock, time) < 10)
            data = num2str(ForwardFlip);
            fwrite(tcpipServer,data,'char');
        elseif(etime(clock, time) < 15)
            data = num2str(BackwardFlip);
            fwrite(tcpipServer,data,'char');
        else 
            data = num2str(land);
            fwrite(tcpipServer,data,'char');
        end
        
        count = count + 1;
        pause(1);

end

fclose(tcpipServer);







