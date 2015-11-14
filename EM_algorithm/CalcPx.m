function Px = CalcPx(Alpha, Beta)

T = length(Alpha(:,1));
n = length(Alpha(1,:));
Px = zeros(T, n);%Px = Gamma_i(t)

for t = 1:T
    Pxt = Beta(t,:).*Alpha(t,:);
    Pxt = Pxt/sum(Pxt,2);
    Px(t,:) = Pxt;
end 