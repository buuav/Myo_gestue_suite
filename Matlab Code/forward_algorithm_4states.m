
load('20160201T132726_NFUD_aam_feb1.mat');
t1 = tcpip('128.197.50.79', 3000,'NetworkRole','client');
set(t1, 'InputBufferSize', 400);
fopen(t1);
count = 1;
time=clock;
fs=200;
wsize=fs/2;
wind = 1;
o = 10;

%nor__OUT_FIST_In_spread
%up_normal_fist_down
while etime(clock,time)<200
    if t1.BytesAvailable
        %data(i,:) = strsplit(fread(t),'\r\n');
        data(count,:) = fscanf(t1, '%d,%d,%d,%d,%d,%d,%d,%d\r\n')';
        [m,n]=size(data);
        %mod(m,wsize)
        if ~mod(m,o) && m > 99
            
            %             dataAvg(wind,:) = mean(data(m-wsize+1:m,:)^2);
            %             dataAvgd=dataAvg+128;
            %             dataAvgd=dataAvgd./256;
            dataStd(wind,:) = std(data(m-wsize+1:m,:));
            Y=dataStd(wind,:)./128;
            norml=diag(Normal(Y',Mu, R, 4));
            %norml=norml/max(max(norml));
            if wind==1
                Alpha(wind,:) = norml*p0;
            else
                Alpha(wind,:) = (norml*P*Alpha(wind-1,:)')';
                Alpha(wind,:) = Alpha(wind,:)/mean(Alpha(wind,:));
            end
            
            [value ,mystate]= max(Alpha(wind,:))
            wind = wind + 1;
        end
        count = count + 1;
    end
end

fclose(t1);








