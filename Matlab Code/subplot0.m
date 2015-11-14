figure
suptitle('Original Data')
[a,b]=size(data);
psize=3;
xaxis=1/200:1/200:a/200;
nlines=round(a/600);
for i=1:b
    subplot(4,2,i);
    plot(xaxis,data(:,i));
    %title('hi %i',i);
    for j=1:nlines
    line([3*j 3*j], [-200 200]);
    end
end

figure
suptitle('filtered Data')
[a,b]=size(data);
[c,d]=butter(9,0.5);
filt_data=filter(c,d,data);
psize=3;
xaxis=1/200:1/200:a/200;
nlines=round(a/600);
for i=1:b
    subplot(4,2,i);
    plot(xaxis,filt_data(:,i));
    %title('hi %i',i);
    for j=1:nlines
    line([3*j 3*j], [-200 200]);
    end
end

figure
suptitle('spectrogram Data')
for i=1:b
    subplot(4,2,i);
    %[S,F,T,P{i}]=spectrogram(data(:,b),200,100,256,200);
    spectrogram(data(:,i),200,100,256,200,'yaxis');
     xlabel('Time');
      ylabel('Frequency (Hz)');
    %title('hi %i',i);
    for j=1:nlines
    line([3*j 3*j], [-200 200]);
    end
end
