function Pxx = CalcPxx(Y, Alpha, Beta, P, Mu, R)

T = length(Alpha(:,1));
n = length(Alpha(1,:));
Pxx = zeros(T-1, n^2);% What unit is this looks like xi but computationally seems different

for t = 1:T-1
    %diag(Normal(Y(t+1,:)', Mu, R, n))
    Pxxt = (diag(Normal(Y(t+1,:)', Mu, R, n))*Beta(t+1,:)'*Alpha(t,:)).*P;%
    Pxxt = reshape(Pxxt,1,n^2);
    Pxxt = Pxxt/sum(Pxxt,2);
    Pxx(t,:) = Pxxt;
end 
    