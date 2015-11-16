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

t = tcpip('128.197.50.236', 3000,'NetworkRole','client');
set(t, 'InputBufferSize', 64);
fopen(t);
count = 1;
time=clock;
fs=200;
%nor__OUT_FIST_In_spread
while etime(clock,time)<200
    if t.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        raw_data(count,:) = fscanf(t, '%d,%d,%d,%d,%d,%d,%d,%d\r\n')';
        Y=raw_data(count,:)+128;
        Y=Y./256;
        norml=diag(Normal(Y',Mu, R, 7));
        %norml=norml/max(max(norml));
        if count==1
            Alpha(count,:) = norml*p0;
        else
            Alpha(count,:) = (norml*P*Alpha(count-1,:)')';
            Alpha(count,:) = Alpha(count,:)/mean(Alpha(count,:));
        end
        
        [value ,mystate(count)] = max(Alpha(count,:)); 
        
        if ~mod(count, 100)
            tempdata=mean(mystate(count-99:count));
            data = num2str(round(tempdata))
            fwrite(tcpipServer,data,'char');
        end
        
        count = count + 1;
    end
end

fclose(t);
fclose(tcpipServer);







