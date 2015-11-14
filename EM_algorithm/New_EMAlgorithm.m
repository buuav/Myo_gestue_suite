
function [Mu, R, P, p0, Px, E] = New_EMAlgorithm(Y)
[a,N]=size(Y);
p0 = [.5; .5; .5; .5; .5];
P = [.6 .1 .1 .1 .1;.1 .6 .1 .1 .1;.1 .1 .6 .1 .1;.1 .1 .1 .6 .1;.1 .1 .1 .1 .6 ];
n = 5;%number of states
%N = 14;%number of observation
for i=1:n
R{i} = .1*eye(N);
Mu{i}= rand(N,1);
end
% Mu{1} = [.5; 0; 0; 0.2; 0; 0; 0; 0.2; 0; 0; 0; 0; 0; 0;];
% Mu{2} = [.6; 0; 0; 0.4; 0; 0; 0; 0; 0; 0; 0.5; 0; 0; 0;];
% Mu{3} = [.7; 0; 0.7; 0; 0; 0; 0; 0.5; 0; 0; 0; 0; 0; 0;];
% Mu{4} = [.5; 0.3; 0; 0; 0; 0; 0; 0.1; 0; 0; 0; 0; 0; 0;];
% Mu{5} = [.4; 0; 0; 0.3; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0;];
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
    mean{i}=Mu{1};
    if i>2
    change=norm(mean{i}-mean{i-1})
    if change<0.001
        break
    end
    end
end

