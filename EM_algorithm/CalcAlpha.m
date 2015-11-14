function Alpha = CalcAlpha(p0, P, Mu, R, Y)

T = length(Y(:,1));%T-training data window or time period   Y is observation matrix
n = length(p0);%n=number of states.
Alpha(1,:) = diag(Normal(Y(1,:)',Mu, R, n))*p0;%p0-initial state probabilities.
Alpha(T,:) = zeros(n,1); %this is required for fast running- allocates the necessary memory at begining.
for t = 2:T 
    Alpha(t,:) = (diag(Normal(Y(t,:)', Mu, R, n))*P*Alpha(t-1,:)')'; % P = a_ij=state transition matrix. 
    Alpha(t,:) = Alpha(t,:)/mean(Alpha(t,:));
end
