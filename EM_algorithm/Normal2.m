function p = Normal(y,Mu,R,n)
N = length(Mu{1});
scale = 1e50;
for i = 1:n
    p(i,1) = scale*1/sqrt((2*pi)^N*det(R{i}))*exp(-1/2*(y-Mu{i})'/(R{i})*(y-Mu{i})); 
end
