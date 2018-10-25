%close all;clear;
x = (0:8).^2;
f = 0:8;

xQuery = 0:0.1:64;

solver = 'secondOrder';
boundaryCond = [0,0];
[M, tri2,d2] = cubicSpline(x, f, boundaryCond, solver);
fprintf('M value for cubic spline\n')
display(M)

fvalue = zeros(2, length(xQuery));
lagrCoeff =  lagrangepoly(x,f);
fvalue(1,:) = lagrangepoly(x,f,xQuery);
fprintf('coefficients for larange interpolation\n')
display(lagrCoeff)
for i = 1:length(xQuery)
    [fvalue(2, i)] = evalcubicSpline(xQuery(i),M, x, f);
    [fvalue(3, i)] = spline(x, f, xQuery(i));
end

figure()
plot(xQuery, fvalue(1,:), '-.', 'lineWidth', 2)
hold on
plot(xQuery, fvalue(2,:), ':', 'lineWidth', 2)
legend('Newton', '3rd Spline')
plot(xQuery, fvalue(3,:), '--', 'lineWidth', 2)

plot(xQuery, sqrt(xQuery), '-', 'LineWidth', 2)
legend('lagrange', 'cubic Spline', 'matlab built-in spline', 'sqrt(x)')
grid on