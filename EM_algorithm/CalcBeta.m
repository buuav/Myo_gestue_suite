function Beta = CalcBeta_f_b(p0, P, Mu, R, Y)
T = length(Y(:,1));
n = length(p0);
Beta(T,:) = ones(1,n);
for t = T-1:-1:1
    Beta(t,:) = Beta(t+1,:)*diag(Normal(Y(t+1,:)', Mu, R, n))*P;
    Beta(t,:) = Beta(t,:)/mean(Beta(t,:));
end
