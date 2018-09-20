% P21 Q17 验证MATLAB代码
clc;clear;close all
% 迭代次数
iters = 100;
% 预分配存储迭代结果及误差
xUpd = zeros(iters, 2);
err = zeros(iters, 2);
% 精确解
xPrc = (sqrt(5) - 1)/2;
% 初始值
xInit = 1;
omiga = 7/25;

xUpd_iter = xInit;
xUpd_relax = xInit;
for i = 1:iters
    
    % 迭代格式x_k = 1/(1+x_k)
    xUpd(i,1) = 1 /(1+ xUpd_iter);
    err(i,1) = abs(xUpd(i,1) - xPrc);
    % 松弛法
    xUpd(i, 2) = omiga * xUpd_relax + (1 - omiga)/(1+xUpd_relax);
    err(i,2) = abs(xUpd(i,2) - xPrc);
    
    % 更新 
    xUpd_iter = xUpd(i, 1);
    xUpd_relax = xUpd(i, 2);
end

figure('color','white')
plot(1:iters, err(:,1),'-o', 'lineWidth',2,'markerSize',2);
hold on
plot(1:iters, err(:, 2),'-s', 'lineWidth', 2,'markerSize',2)
l = legend('$x_{k}=\frac{1}{1+x_{k}}$','relaxation scheme');
set(l,'Interpreter','Latex');
xlabel('iterations')
ylabel('|x_{k}-x_{*}|')
grid on
