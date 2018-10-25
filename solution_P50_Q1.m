% P50页第1题
close all
clear;clc;
x = [0.2, 0.4, 0.6, 0.8, 1.0];
f = [0.98, 0.92, 0.81, 0.64, 0.38];


[aveErrTable] = generateAvegErrTable(x, f);
fprintf('print newton interpolation table\n')
printTable = vpa([x', aveErrTable]);
display(printTable)

% 自然边界
solver = 'secondOrder';
boundaryCond = [0,0];
[M, tri, d] = cubicSpline(x, f, boundaryCond, solver);
fprintf('M value for cubic spline\n')
display(M)
%% 计算4次牛顿插值和三次样条插值
xQuery = [0, 1, 10, 11]*0.08 + 0.2;
% xQuery = x;
fvalue = zeros(3, length(xQuery));
for i = 1:length(xQuery)
    [fvalue(1, i)] = newtonIntpt(xQuery(i), x, aveErrTable, 4);
    [fvalue(2, i)] = evalcubicSpline(xQuery(i),M, x, f);
    [fvalue(3, i)] = spline(x, f, xQuery(i)); % matlab自带函数
end
figure()
plot(xQuery, fvalue(1,:), 'v-.', 'lineWidth', 2, 'MarkerSize', 4)
hold on
plot(xQuery, fvalue(2,:), 's-', 'lineWidth', 2, 'MarkerSize', 4)
legend('Newton', '3rd Spline')
plot(xQuery, fvalue(3,:), 'o-', 'lineWidth', 2, 'MarkerSize', 4)
legend('Newton', 'cubic Spline', 'matlab built-in spline')
grid on
