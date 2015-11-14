
function [Mu, R, P, p0, Px, E] = EMAlgorithm_2_states(Y)
[a,N]=size(Y);
p0 = [.5; .5];
P = [.9 .1;.1 .9];
n = 2;%number of states
%N = 14;%number of observation
for i=1:n
R{i} = .2*eye(N);
end
Mu{1} = [.1;0.2];
Mu{2} = [.4;0.7];
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

for i = 1:20
    alphaimo = alpha;
    [Pxx, Px] = Estep(p0, P, Mu, R, Y);
    [Mu, R, P, p0] = Mstep(Px, Pxx, Y);
    alpha = [reshape(P,n^2,1); p0];
    for j = 1:length(p0)
        alpha = [alpha; reshape(R{j},N^2,1); Mu{j}];
    end
    E(i) = norm(alpha-alphaimo);
    i
    mean{i}=Mu{1};
    if i>2
    change=norm(mean{i}-mean{i-1})
    if change<0.001
        break
    end
    end
end

