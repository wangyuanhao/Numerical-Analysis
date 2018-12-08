function [evalf] = eval_trifunc(xfit, an, bn,M)
% 计算M阶三角多项式的值
evalf = (an(1)+bn(1))/2;
for k = 1:M
    evalf = evalf + an(k+1).*cos(k.*xfit)+ bn(k+1).*sin(k.*xfit); 
end
end