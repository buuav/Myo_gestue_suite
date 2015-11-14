function [ve, vn] = CalcVelocity(t, e, n)
% numerically calculates the velocity as differences of positions over
% differences  of time
leng = length(t);

%conversion factor
tconversion = 24*60*60;

%convert to seconds
t = t*tconversion;

t0 = t(1:leng-1);
t1 = t(2:leng);
e0 = e(1:leng-1);
e1 = e(2:leng);
n0 = n(1:leng-1);
n1 = n(2:leng);
deltat = t1-t0;
deltae = e1-e0;
deltan = n1-n0;

%velocities in m/s
ve = deltae./deltat;
vn = deltan./deltat;
ve = [ve(1); ve];
vn = [vn(1); vn];
