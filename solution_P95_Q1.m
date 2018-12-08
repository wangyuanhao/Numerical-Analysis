clc;clear;close all
x = (-1:0.2:1)';
A = [x.^3, x.^2, x, ones(length(x), 1)];
f = fracFunc(x);
%b = inv(A)*f;
bfit = (A'*A)\(A'*f);

evalf = A*bfit;

xfit = (-1:0.01:1)';
Afit = [xfit.^3, xfit.^2, xfit, ones(length(xfit),1)];
ffit = Afit*bfit;

figure()
plot(x, evalf);
hold on
plot(x, f);
plot(xfit, ffit)
