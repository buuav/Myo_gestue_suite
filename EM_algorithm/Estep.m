function [Pxx, Px] = Estep(p0, P, Mu, R, Y)

Alpha = CalcAlpha(p0, P, Mu, R, Y);
Beta = CalcBeta(p0, P, Mu, R, Y);
Pxx = CalcPxx(Y, Alpha, Beta, P, Mu, R);
Px = CalcPx(Alpha, Beta);
