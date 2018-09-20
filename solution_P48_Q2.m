% P48 Q2 MATLAB代码
x = [0.4, 0.5, 0.6, 0.7, 0.8];
fx = [-0.916291,-0.693147,-0.510826,-0.356675,-0.223144];

% 线性插值
qPoint = 0.54;
linearItpl = interp1(x,fx, qPoint);

% 二次插值
% 插值点x=0.5,0.6,0.7
quadraticItplLeft = lagrangepoly(x(2:4),fx(2:4),qPoint);
quadraticItplRight = lagrangepoly(x(1:3),fx(1:3),qPoint);

fprintf('ln(%.2f)线性插值的近似值:%f\n', qPoint, linearItpl);
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('使用插值点:')
disp(x(1:3));
fprintf('ln(%.2f)二次插值的近似值:%f\n', qPoint, quadraticItplRight)
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('使用插值点:')
disp(x(2:4))
fprintf('ln(%.2f)二次插值的近似值:%f\n', qPoint, quadraticItplLeft)



