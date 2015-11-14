function ClusterPlot(Y, R, Mu, n)

FS = 'FontSize';
fs = 24;
FW = 'FontWeight';
fw = 'bold';
FA = 'FontAngle';
fa = 'normal';
LW = 'LineWidth';
lw = 3;
MS = 'MarkerSize';
ms = 1;

T = length(Y(:,1));
l = plot(Y(1:10:T,1), Y(1:10:T,2), '.', MS, ms, LW, lw);
%legend('Cow 1', 'Cow 2', 'Cow 3', 'Location', 'SouthEast');
xlabel('Speed (m/s)', FS, fs, FW, fw, FA, fa);
ylabel('Head Angle (rad)', FS, fs, FW, fw, FA, fa);
set(gca, 'XLim', [0 1.2], 'YLim', [-1 1], FS, fs, FW, fw, LW, lw); 
hold on;
for i = 1:n
    plot(Mu{i}(1), Mu{i}(2), 'xr');
    h = error_ellipse(R{i}, Mu{i}, .5);
    set(h, LW, lw-1, 'Color', 'r');
end
hold off;


