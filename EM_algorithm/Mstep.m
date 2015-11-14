function [Mu, R, P, p0] = Mstep(Px, Pxx, Y)

T = length(Y(:,1));
N = length(Y(1,:));
n = length(Px(1,:));

for i = 1:n
    Mu{i} = sum((Px(:,i)*ones(1,N)).*Y)'/sum(Px(:,i));
    Ydiff = (Y-ones(T,1)*Mu{i}');
    for j = 1:N
        R{i}(:,j) = sum((Px(:,i)*ones(1,N)).*(Ydiff(:,j)*ones(1,N)).*Ydiff)/sum(Px(:,i));
    end
end

P = reshape(sum(Pxx),n,n)./(ones(n,1)*sum(Px(1:T-1,:)));
p0 = Px(1,:)';