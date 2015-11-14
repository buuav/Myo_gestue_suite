
function [Mu, R, P, p0, Px, E] = EMAlgorithm_kmeans(Y)

p0 = [.5; .5; .5; .5; .5];
P = [.6 .1 .1 .1 .1;.1 .6 .1 .1 .1;.1 .1 .6 .1 .1;.1 .1 .1 .6 .1;.1 .1 .1 .1 .6 ];
n = 5;%number of states
N = 14;%number of observation
[idx C]=kmeans(Y,5);%k-means initialization
for i=1:n
R{i} = .1*eye(N);
Mu{i}= C(i,:)';
end

% p0 = [.5; .5; .5; .5];
% P = [.7 .1 .1 .1; .1 .7 .1 .1; .1 .1 .7 .1; .1 .1 .1 .7];
% n = 4;
% N = 2;
% 
% Mu{1} = [.4; 0];
% R{1} = .1*eye(2);
% 
% Mu{2} = [.5; 0];
% R{2} = .1*eye(2);
% 
% Mu{3} = [.6; 0];
% R{3} = .1*eye(2);
% 
% Mu{4} = [.7; 0];
% R{4} = .1*eye(2);

alpha = [reshape(P,n^2,1); p0];
for j = 1:length(p0)
    alpha = [alpha; reshape(R{j},N^2,1); Mu{j}];
end

for i = 1:10
    alphaimo = alpha;
    [Pxx, Px] = Estep(p0, P, Mu, R, Y);
    [Mu, R, P, p0] = Mstep(Px, Pxx, Y);
    alpha = [reshape(P,n^2,1); p0];
    for j = 1:length(p0)
        alpha = [alpha; reshape(R{j},N^2,1); Mu{j}];
    end
    E(i) = norm(alpha-alphaimo);
    i
end

