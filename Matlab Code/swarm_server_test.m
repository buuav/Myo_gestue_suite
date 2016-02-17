left=0;
right=0;
up=0;
down=0;
mystate=1;
i=1;
t=clock;
bn='\r\n';
n = [0 0 0 20]; %yaw pitch roll altitude
%data = num2str([up,down,left,right,mystate]);
tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
 set(tcpipServer,'OutputBufferSize',400);
  fopen(tcpipServer);
  %while etime(clock,t)<5
  pause(10);
  t=clock
  while etime(clock,t)<1.5
  allOneString = sprintf('%.0f,' , [0 0 0 30 0 15 0 0]); %Up Forward
  allOneString = allOneString(1:end-1);% strip final comma
  %allOneString = sprintf('%s%s',allOneString,bn);
    fwrite(tcpipServer,allOneString,'char')
     pause(0.001);
  end
  pause(1);
  
  t=clock
  while etime(clock,t)<1.5
  allOneString = sprintf('%.0f,' , [0 0 0 30 0 -15 0 0]); %Up Forward
  allOneString = allOneString(1:end-1);% strip final comma
  %allOneString = sprintf('%s%s',allOneString,bn);
    fwrite(tcpipServer,allOneString,'char')
     pause(0.001);
  end
  pause(1);
  
  t=clock
  while etime(clock,t)<1.5
  allOneString = sprintf('%.0f,' , [0 0 15 0 0 0 0 15]); %Left Up
  allOneString = allOneString(1:end-1);% strip final comma
  %allOneString = sprintf('%s%s',allOneString,bn);
    fwrite(tcpipServer,allOneString,'char')
     pause(0.001);
  end
    pause(1);
  t=clock
  while etime(clock,t)<1.5
  allOneString = sprintf('%.0f,' , [0 0 -15 0 0 0 0 -15]); %right down
  allOneString = allOneString(1:end-1);% strip final comma
  %allOneString = sprintf('%s%s',allOneString,bn);
    fwrite(tcpipServer,allOneString,'char')
     pause(0.001);
  end
    pause(0.001);
  
 %end
  i=i+1;
  fclose(tcpipServer);