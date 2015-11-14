function Y = CalcY(output_matrix)
[a,b]=size(output_matrix);
data=output_matrix(129:a-128,4:17);
Y=baseline(data);
[m,n]=size(Y);
hold on;
figure;
for i=1:n
subplot(3,5,i);    
plot(Y(:,i));
axis([0 a -150 150]);
end