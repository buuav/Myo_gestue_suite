t = tcpip('128.197.50.236', 3000,'NetworkRole','client');
set(t, 'InputBufferSize', 64);
fopen(t);
count = 1;
time=clock;
fs=200;

%nor__OUT_FIST_In_spread
while etime(clock,time)<48
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
        
        [value ,mystate]= max(Alpha(count,:))
        count = count + 1;
    end
end

fclose(t);








