left=0;
right=0;
up=0;
down=0;
mystate=1;
data = [up,down,left,right,mystate];
s = whos('data');
 tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
 set(tcpipServer,'OutputBufferSize',s.bytes);
  fopen(tcpipServer);
  for i=1:5
  data = [0,0,0,0,1];    
  fwrite(tcpipServer,data(:),'double');
  pause(1);
  end
  for i=1:2
  data = [1,down,left,right,1];    
  fwrite(tcpipServer,data(:),'double');
  pause(0.5);
  end
  for i=1:5
  data = [0,0,0,0,2];    
  fwrite(tcpipServer,data(:),'double');
  pause(1);
  end
  for j=1:2
  data = [0,1,left,right,2];    
  fwrite(tcpipServer,data(:),'double');
  pause(0.5);
  end
  for i=1:5
  data = [0,0,0,0,1];    
  fwrite(tcpipServer,data(:),'double');
  pause(0.2);
  end
%   for j=1:2
%   data = [0,0,1,right,1];    
%   fwrite(tcpipServer,data(:),'double');
%   pause(1);
%   end
  for i=1:5
  data = [0,0,0,0,2];    
  fwrite(tcpipServer,data(:),'double');
  pause(1);
  end
% for j=1:2
%   data = [0,0,0,1,2];    
%   fwrite(tcpipServer,data(:),'double');
%   pause(1);
% end
  for i=1:5
  data = [0,0,0,0,1];    
  fwrite(tcpipServer,data(:),'double');
  pause(1);
  end
  fclose(tcpipServer);