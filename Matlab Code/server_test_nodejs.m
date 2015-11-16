left=0;
right=0;
up=0;
down=0;
mystate=1;
i=1;
%data = num2str([up,down,left,right,mystate]);
s = whos('data');
tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
 set(tcpipServer,'OutputBufferSize',s.bytes);
  fopen(tcpipServer);
while(i<1000)
  data = num2str([up,down,left,right,mystate+i]);
    fwrite(tcpipServer,data,'char');
  pause(0.01);
  i=i+1;
end
  fclose(tcpipServer);