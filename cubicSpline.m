function  [M,triTriangle, d] = cubicSpline(x, f, boundaryCond, solver)
% 三次样条插值
% 给定x对应的函数值
% 要求x升序排列

numPoint = length(x);
h = diff(x);
aveErrTable = generateAvegErrTable(x, f);

lambda = zeros(numPoint-2, 1);
mu = zeros(numPoint-2, 1);
d = zeros(numPoint-2, 1);

for j = 1:numPoint - 2
    lambda(j) = h(j+1) / (h(j) + h(j+1));
    mu(j) = h(j) / (h(j) + h(j+1));
    d(j) = 6*aveErrTable(j+2, 3);
end

switch solver
    case 'firstOrder'
        lambda0 = 1;
        d0 = 6/h(1)*(aveErrTable(2,2) - boundaryCond(1));
        mu_add = 1;
        d_add = 6*(boundaryCond(2) - aveErrTable(end, 2))/h(end);
        triTriangle = diag([lambda0; lambda], 1) + 2*eye(numPoint) + diag([mu;mu_add], -1);
        d = [d0;d;d_add];
        M = triTriangle\d;

    case 'secondOrder'
        lambda0 = 0;
        mu_add = 0;
        d0 = 2*boundaryCond(1);
        d_add = 2*boundaryCond(2);
        triTriangle = diag([lambda0; lambda], 1) + 2*eye(numPoint) + diag([mu;mu_add], -1);
        d = [d0;d;d_add];
        M = triTriangle\d;
    case 'period'
        lambda_add = h(1) / (h(1)+h(end));
        mu_add = 1 - lambda_add;
        d_add = 6*(aveErrTable(2,2) - aveErrTable(end, 2))/(h(1)+h(end));
        
        qTriTriangle = diag(lambda, 1) + 2*eye(numPoint-2) + diag([mu(2:end);mu_add], -1);
        qTriTriangle(end, 1) = lambda_add;
        qTriTriangle(1, end) = mu(1);
        
        M = qTriTriangle\[d; d_add];
        M = [M(end), M];     
end
end